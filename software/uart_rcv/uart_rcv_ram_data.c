

#include "altera_avalon_uart_regs.h"
#include "sys/alt_irq.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"



//volatile  alt_u8 SendBuf[24],ReceBuf[4];
volatile  alt_u8 SendBuf[2048],ReceBuf[4];
volatile alt_u16 send_ptr;
volatile alt_u8 tempRece;
volatile alt_u8 wr_flag;
volatile alt_u32 rcv_data,send_data;

volatile alt_u8 RxPtr,RxStart;
 volatile alt_u8 m_s;
//volatile int  uart_iq_capture;
//volatile int pio_iq_capture;
alt_u32 cnt;
alt_u8 i;
//////////////////////////uart inithilization///////////////////////////////////////////////
void uart_init(void)
 {

  IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X00C0);// enalbe interruption of  txd and rxd
  IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE, 0X0000);

 }


void data_rcv_isr (void* context,alt_u32 id)
{

	 /*      if (cnt==1)
			 {
				  cnt=0;
				  IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x00);
			 }
			 else
			 {
				 cnt=1;
				 IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x01);
			 }

			 */
	/**********************************LED TEST*********************************************/
 	      if (cnt>=50)
	      		 {
	      			  cnt=0;
	      		 }
	      		 else
	      		 {
	      			 cnt=cnt+1;
	      		    if (cnt>=25)
	      		 	 {
	      		 	       IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x01);

	      		 	 }
	      		   else
	      		    {

	      			   IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x00);
	      		    }
	      		 }

 /*************************************************************************************************/


	             IOWR_ALTERA_AVALON_PIO_EDGE_CAP(DATA_IN_VALID_BASE,0x00);

	             rcv_data=IORD_ALTERA_AVALON_PIO_DATA(DATA_IN_BASE);

				 SendBuf[0+4*i]=(rcv_data>>24)&0xFF;
				 SendBuf[1+4*i]=(rcv_data>>16)&0xFF;
				 SendBuf[2+4*i]=(rcv_data>>8)&0xFF;
				 SendBuf[3+4*i]=rcv_data&0xFF;



			if (i==5)
			{
				 i=0;
				 if (wr_flag==0)
				 	 {
				 		 wr_flag=1;
				 		 IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[0]);
				 		 send_ptr++;
				 		 uart_init();
				      }

				 if (m_s==0)
					 {
					     rcv_data=IORD_ALTERA_AVALON_PIO_DATA(DATA_IN_BASE);
					     IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_BASE,rcv_data);
						 IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_VALID_BASE,0x01);
						 IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_VALID_BASE,0x00);
					 }

			 }

			 else
			 {
				 i=i+1;
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


            		 }
		    else if (RxStart==1)
		    {
		    	ReceBuf[RxPtr]=tempRece;
		    	RxPtr++;
		    	if (RxPtr==4)
		    	{
		    		RxPtr=0;
		    		RxStart=0;
		    		send_data=((ReceBuf[0]|0x00000000)<<24)|((ReceBuf[1]|0x00000000)<<16)|((ReceBuf[2]|0x00000000)<<8)|ReceBuf[3];//0x5A5A5A5A;
		    		IOWR_ALTERA_AVALON_PIO_DATA(MASTER_SLAVE_BASE,0x01);//master_salve=1;
		    		m_s=1;
		    		IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_BASE,send_data);
		    		IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_VALID_BASE,0x01);
		    		IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_VALID_BASE,0x00);
		    		uart_init();
		    	}
		    }
		   }
		else if ((IORD_ALTERA_AVALON_UART_STATUS(UART_BASE)&0X0040)==0x0040)
	     {

           if (wr_flag==1)
           {
			 if (send_ptr<24)
             {
               IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[send_ptr]);
               send_ptr++;
                 if (send_ptr==24)
                    {
                         send_ptr=0;
                         wr_flag=0;
                         IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X0080);
                         IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE,0X0000);
                    }
              }
           }
	     }

}

void rcv_ram_isr (void* context,alt_u32 id)
{
	             alt_u16 i,adr;


	             IOWR_ALTERA_AVALON_PIO_EDGE_CAP(RCV_RAM_WR_END_BASE,0x00);

	             IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x00);
	             adr=0;
                 for (i=0;i<1024;i++)
                 {
                	 adr++;
                	 IOWR_ALTERA_AVALON_PIO_DATA(RD_ADR_BASE,adr);
		             IOWR_ALTERA_AVALON_PIO_DATA(RD_CLK_BASE,0);
		             delay(1);
		             IOWR_ALTERA_AVALON_PIO_DATA(RD_CLK_BASE,1);
		             delay(1);

		             rcv_data=IORD_ALTERA_AVALON_PIO_DATA(RCV_RAM_DATA_BASE);
		             SendBuf[2*i]=(rcv_data>>8)&0xFF;
		             SendBuf[2*i+1]=rcv_data&0xFF;
                 }

			  	 if ((wr_flag==0))
		 	      {
		 	   	    wr_flag=1;
		 	    	IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[0]);
		 	    	send_ptr++;
		 	    	uart_init();
		 	      }




}
/*********************************************************************/

void uart_for_rcv_ram_isr (void* context,alt_u32 id)
{

	//if ((IORD_ALTERA_AVALON_UART_STATUS(UART_BASE)&0X0040)==0x0040)

	 {

        if( wr_flag==1)
        {
          if (send_ptr<2048)
            {
             IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[send_ptr]);
             send_ptr++;
               if (send_ptr==2048)
                  {
                       send_ptr=0;
                       wr_flag=0;
                       IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X0000);
                       IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE,0X0000);
                   }
            }
         }
   }
}

void delay(unsigned int i)
{
  while(i--)
  {
	  unsigned int j;
	  for (j=1;j<10;j++)
		  ;
  }
}



int main (void)
{

	int uart_iq_capture,pio_iq_capture;

 send_ptr=0;
 wr_flag=0;
 RxPtr=0;
 RxStart=0;
 IOWR_ALTERA_AVALON_PIO_DATA(MASTER_SLAVE_BASE,0x00);//master_salve=0;
 m_s=0;
 cnt=0;
 i=0;



     //  alt_irq_register(DATA_IN_VALID_IRQ, (void*)&pio_iq_capture, data_rcv_isr);

     //  alt_irq_register(UART_IRQ, (void*)&uart_iq_capture, uart_rx_tx_isr);

    alt_irq_register(RCV_RAM_WR_END_IRQ, (void*)&pio_iq_capture, rcv_ram_isr);

    alt_irq_register(UART_IRQ, (void*)&uart_iq_capture, uart_for_rcv_ram_isr);

    IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x01);
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(DATA_IN_VALID_BASE,0xFF);
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(DATA_IN_VALID_BASE,0x00);
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(RCV_RAM_WR_END_BASE,0xFF);
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(RCV_RAM_WR_END_BASE,0x00);

    //uart_init();




    IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_VALID_BASE,0x00);



while(1)
 {

/*

	 if (cnt>=5000000)
		 {
			  cnt=0;
			  //IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, 0XFF);
		 }
		 else
		 {
			 cnt=cnt+1;
		    if (cnt>=2500000)
		 	 {
		 	       IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x01);

		 	 }
		   else
		    {

			   IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x00);
		    }
		 }
*/


 }
return 0;
}








