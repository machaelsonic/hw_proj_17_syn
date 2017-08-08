/*
 * uart_rcv.c
 *
 *  Created on: 2017-5-17
 *      Author: Lenovo
 */



#include "altera_avalon_uart_regs.h"
#include "sys/alt_irq.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"



volatile  alt_u8 SendBuf[5],ReceBuf[5];
volatile alt_u8 send_ptr;
volatile alt_u8 tempRece;
volatile alt_u8 wr_flag;
volatile alt_u32 rcv_data_l,send_data_l;
volatile alt_u8 rcv_data_h,i,send_data_h;
volatile alt_u8 RxPtr,RxStart;
volatile alt_u8 master;
//volatile int  uart_iq_capture;
//volatile int pio_iq_capture;

//////////////////////////uart inithilization///////////////////////////////////////////////
void uart_init(void)
 {

  IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X00C0);// enalbe interruption of  txd and rxd
  IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE, 0X0000);

 }


void data_rcv_isr (void* context,alt_u32 id)
{
                 //volatile int* pio_iq_capture=(volatile int*) context1;
	             IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PRE_COME_BASE,0x00);
	             rcv_data_l=IORD_ALTERA_AVALON_PIO_DATA(DATA_L_BASE);
			     rcv_data_h=IORD_ALTERA_AVALON_PIO_DATA(DATA_H_BASE);
			     //IOWR_ALTERA_AVALON_PIO_DATA(DATA_CLR_BASE,0x00);
			     //IOWR_ALTERA_AVALON_PIO_DATA(DATA_CLR_BASE,0x00);
			     SendBuf[0]=rcv_data_h&0x0F;
				 SendBuf[1]=(rcv_data_l>>24)&0xFF;
				 SendBuf[2]=(rcv_data_l>>16)&0xFF;
				 SendBuf[3]=(rcv_data_l>>8)&0xFF;
				 SendBuf[4]=rcv_data_l&0xFF;


		     //if ((SendBuf[0]==0x0A)&&(wr_flag==0))
			 if (wr_flag==0)
		 	      {
		 	   	    wr_flag=1;
		 	    	IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[0]);
		 	   	    //IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, 0xFF);
		 	    	send_ptr++;
		 	    	//uart_init();
		 	      }
			if (master==0)
			{
				IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_L_BASE,rcv_data_l);
				IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_H_BASE,rcv_data_h);
				IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_VALID_BASE,0x01);
				IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_VALID_BASE,0x00);

			}

}

////////////////////////////uart receive data //////////////////////////////
void uart_rx_tx_isr (void* context,alt_u32 id)
{
	 //volatile int* uart_iq_capture=(volatile int*) context2;
	 if ((IORD_ALTERA_AVALON_UART_STATUS(UART_BASE)&0X0080)==0x0080)
		   {

		    tempRece=(IORD_ALTERA_AVALON_UART_RXDATA(UART_BASE)&0xff);
		    if(RxStart==0)
		            {
		              RxPtr=0;
		              ReceBuf[RxPtr]=tempRece;
		              RxPtr++;
            		 if (ReceBuf[0]==0x0A)
		                {
            			    RxStart=1;
		                 }
            		 else
            		 {
            			 RxStart=0;
            		 }

		              //RxStart=1;
            		 }
		    else if (RxStart==1)
		    {
		    	ReceBuf[RxPtr]=tempRece;
		    	RxPtr++;
		    	if (RxPtr==5)
		    	{
		    		RxPtr=0;
		    		RxStart=0;
		    		send_data_l=((ReceBuf[1]|0x00000000)<<24)|((ReceBuf[2]|0x00000000)<<16)|((ReceBuf[3]|0x00000000)<<8)|ReceBuf[4];//0x5A5A5A5A;
		    		send_data_h=ReceBuf[0];//0x0A;
		    		master=1;
		    		IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_L_BASE,send_data_l);
		    		IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_H_BASE,send_data_h);
		    		IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_VALID_BASE,0x01);
		    		IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_VALID_BASE,0x00);

		    	}
		    }
		   }
		else if ((IORD_ALTERA_AVALON_UART_STATUS(UART_BASE)&0X0040)==0x0040)
	 {

        if( wr_flag==1)
        {
          if (send_ptr<5)
            {
             IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[send_ptr]);
             send_ptr++;
               if (send_ptr==5)
                  {
                       send_ptr=0;
                        wr_flag=0;
                       //IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X0080);
                       //IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE,0X0000);
                   }
            }
         }
   }
}


int main (void)
{

	int uart_iq_capture,pio_iq_capture;

 send_ptr=0;
 wr_flag=0;
 RxPtr=0;
 RxStart=0;
 master=0;
  alt_irq_register(PRE_COME_IRQ, (void*)&pio_iq_capture, data_rcv_isr);

  //IOWR_ALTERA_AVALON_PIO_DATA(DATA_CLR_BASE,0x00);

 alt_irq_register(UART_IRQ, (void*)&uart_iq_capture, uart_rx_tx_isr);

 IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PRE_COME_BASE,0xFF);
 IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PRE_COME_BASE,0x00);
 uart_init();

while(1)
 {
	                IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_L_BASE,rcv_data_l);
					IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_H_BASE,rcv_data_h);
					IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_VALID_BASE,0x01);
					IOWR_ALTERA_AVALON_PIO_DATA(TX_DATA_VALID_BASE,0x00);


					IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, 0xFF);
 }
return 0;
}



/*
#include "altera_avalon_uart_regs.h"
#include "sys/alt_irq.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"



volatile  alt_u8 SendBuf[5];
volatile alt_u8 send_ptr;
volatile alt_u8 tempRece;
volatile alt_u8 wr_flag;
volatile alt_u32 rcv_data_l;
volatile alt_u8 rcv_data_h,i;

//////////////////////////uart inithilization///////////////////////////////////////////////
void uart_init(void)
 {
  //IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0XC0);// enalbe interruption of txd and rxd
  IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X0000);// enalbe interruption of rxd
  IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE, 0X0000);

 }


void data_rcv_isr (void * context1,alt_u32 id)
{

	             //IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PRE_COME_BASE,0x00);
	             IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PRE_COME_BASE,0x00);
	             rcv_data_l=IORD_ALTERA_AVALON_PIO_DATA(DATA_L_BASE);
			     rcv_data_h=IORD_ALTERA_AVALON_PIO_DATA(DATA_H_BASE);

			     SendBuf[0]=rcv_data_h&0x0F;
				 SendBuf[1]=(rcv_data_l>>24)&0xFF;
				 SendBuf[2]=(rcv_data_l>>16)&0xFF;
				 SendBuf[3]=(rcv_data_l>>8)&0xFF;
				 SendBuf[4]=rcv_data_l&0xFF;

		   // if ((SendBuf[0]==0x0A))
		 	      {
		    	  for (send_ptr=0;send_ptr<5;send_ptr++)
		    	   {
		    		  IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[send_ptr]);
		    	   }
		    	  //IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PRE_COME_BASE,0xFF);
		    	  //send_ptr=0;

				    }

}

////////////////////////////uart receive data //////////////////////////////
void uart_rx_tx_isr (void * context2,alt_u32 id)
{
	 if ((IORD_ALTERA_AVALON_UART_STATUS(UART_BASE)&0X0040)==0x0040)
     {
     if( wr_flag==1)
     {
		if (send_ptr==5)
          {
             send_ptr=0;
             wr_flag=0;
             //IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PRE_COME_BASE,0xFF);
           }
        else
         {
        IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[send_ptr]);
    	//IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[0]);
         send_ptr++;
          }
     }
   }
}


int main (void)
{
   int uart_iq_capture,pio_iq_capture;


 send_ptr=0;
 wr_flag=0;

 alt_irq_register(PRE_COME_IRQ, (void*)&pio_iq_capture, data_rcv_isr);
 //alt_irq_register(UART_IRQ, (void*)&uart_iq_capture, uart_rx_tx_isr);



 uart_init();

 IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PRE_COME_BASE,0xFF);
 IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PRE_COME_BASE,0x00);
 //IOWR_ALTERA_AVALON_PIO_DATA(RCV_DATA_READ_OVER_BASE,0xff);
while(1)
 {
	//IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PRE_COME_BASE,0xFF);
	//IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, 0xAA);
 }
return 0;
}

*/




