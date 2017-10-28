

#include "altera_avalon_uart_regs.h"
#include "sys/alt_irq.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"



volatile  alt_u8 SendBuf[312],ReceBuf[4];
volatile  alt_u8 SendBuf_long[2380];
volatile alt_u16 send_ptr,send_ptr_long;
volatile alt_u8 tempRece;
volatile alt_u8 wr_flag,uart_long;
volatile alt_u16  dma_data;
volatile alt_u32 xmt_ram_wr_buf[78];


volatile alt_u8 RxPtr,RxStart;

alt_u32 cnt;
alt_u8 i,m_s;


void delay(unsigned int i)
{
  while(i--)
  {
	  unsigned int j;
	  for (j=1;j<10;j++)
		  ;
  }
}

//////////////////////////uart inithilization///////////////////////////////////////////////
void uart_init(void)
 {

  IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X00C0);// enalbe interruption of  txd and rxd
  IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE, 0X0000);

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
		    		IOWR_ALTERA_AVALON_PIO_DATA(MASTER_SLAVE_BASE,0x01);//master_salve=1;
		    		m_s=1;
		    		IOWR_ALTERA_AVALON_PIO_DATA(CPU_RD_RAM_BASE,0x00);// ½ûÖ¹CPU¶Ôram¶Á²Ù×÷
		    		//Æô¶¯Âß¼­·¢ËÍ×´Ì¬
		    		IOWR_ALTERA_AVALON_PIO_DATA(CPU_TX_TRIGER_BASE,0x00);
		    		IOWR_ALTERA_AVALON_PIO_DATA(CPU_TX_TRIGER_BASE,0x01);
		    		IOWR_ALTERA_AVALON_PIO_DATA(CPU_TX_TRIGER_BASE,0x00);
		    	}
		    }
		   }
		else if ((IORD_ALTERA_AVALON_UART_STATUS(UART_BASE)&0X0040)==0x0040)
	     {

           if (wr_flag==1)
           {
        	 if (uart_long==0)
        	 {
			   if (send_ptr<312)
                 {
                   IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[send_ptr]);
                   SendBuf[send_ptr]=0;
                   send_ptr++;
                   if (send_ptr==312)
                       {
                         send_ptr=0;
                         wr_flag=0;
                         IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X0080);
                         IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE,0X0000);
                       }
                 }
        	 }
        	 else if (uart_long==1)
        	 {
        		 if (send_ptr<2380)
        		    {
        		      IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf_long[send_ptr_long]);
        		      SendBuf_long[send_ptr_long]=0;
        		      send_ptr_long++;
        		      if (send_ptr_long==2380)
        		         {
        		           send_ptr_long=0;
        		           wr_flag=0;
        		           IOWR_ALTERA_AVALON_UART_CONTROL(UART_BASE, 0X0080);
        		           IOWR_ALTERA_AVALON_UART_STATUS(UART_BASE,0X0000);
        		         }
        		    }
        	 }
           }
	     }

}

void xmt_ram_wr (void)
{
        alt_u16 i,adr;

        adr=0;
        for (i=0;i<78;i++)
            {
        	  xmt_ram_wr_buf[i]=i+1;
              IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_EN_BASE,0x01);
              IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_ADR_BASE,adr);
              IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_DATA_BASE,xmt_ram_wr_buf[i]);
    		  IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_CLK_BASE,0);
    		  delay(1);
    		  IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_CLK_BASE,1);
    		  delay(1);
        	  adr++;
            }

        IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_EN_BASE,0x00);
        IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_ADR_BASE,0x00);
        IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_CLK_BASE,0);
        IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_WR_DATA_BASE,0x00);

}

void xmt_ram_rd (void)
{
        alt_u16 i,adr;
        alt_u32 rd_data;
        adr=0;

        IOWR_ALTERA_AVALON_PIO_DATA(CPU_RD_RAM_BASE,0x01);// ÔÊÐíCPU¶Ôram¶Á²Ù×÷
        for (i=0;i<78;i++)
            {
              IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_EN_BASE,0x01);
              IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_ADR_BASE,adr);
    		  IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_CLK_BASE,0);
    		  delay(1);
    		  IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_CLK_BASE,1);
    		  delay(1);
    		  rd_data=IORD_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_DATA_BASE);
    		  SendBuf[4*i]=(rd_data>>24)&0xFF;
    		  SendBuf[4*i+1]=(rd_data>>16)&0xFF;
    		  SendBuf[4*i+2]=(rd_data>>8)&0xFF;
    		  SendBuf[4*i+3]=rd_data&0xFF;
    		  adr++;
            }
        IOWR_ALTERA_AVALON_PIO_DATA(CPU_RD_RAM_BASE,0x00);// ½ûÖ¹CPU¶Ôram¶Á²Ù×÷
        IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_EN_BASE,0x00);
        IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_ADR_BASE,0x00);
        IOWR_ALTERA_AVALON_PIO_DATA(CPU_XMT_RAM_RD_CLK_BASE,0);
        if (wr_flag==0)
        	 {
        		 wr_flag=1;
        		 uart_long=0;
                 IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[0]);
                 SendBuf[0]=0;
                 send_ptr++;
                 uart_init();
        	 }

}
/*
void rx_ram_rd(void)
{
	      alt_u16 i,adr;
	      alt_u32 rd_data;
	       adr=0;
		  IOWR_ALTERA_AVALON_PIO_DATA(CPU_RD_RAM_BASE,0x01);// ÔÊÐíCPU¶Ôram¶Á²Ù×÷

		   for (i=0;i<78;i++)
		        {

		          IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_EN_BASE,0x01);
		          IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_ADR_BASE,adr);
		     	  IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_CLK_BASE,0);
		     	  delay(1);
		     	  IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_CLK_BASE,1);
		     	  delay(1);
		     	  rd_data=IORD_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_DATA_BASE);
		     	  SendBuf[4*i]=(rd_data>>24)&0xFF;
		     	  SendBuf[4*i+1]=(rd_data>>16)&0xFF;
		     	  SendBuf[4*i+2]=(rd_data>>8)&0xFF;
		     	  SendBuf[4*i+3]=rd_data&0xFF;
			      adr++;
	            }
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RD_RAM_BASE,0x00);// ½ûÖ¹CPU¶Ôram¶Á²Ù×÷
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_EN_BASE,0x00);
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_ADR_BASE,0x00);
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_CLK_BASE,0);
		         if (wr_flag==0)
		         	 {
		         		  wr_flag=1;
		         		  uart_long=0;
		                  IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf[0]);
		                  SendBuf[0]=0;
		                  send_ptr++;
		                  uart_init();
		         	 }

}

*/
void rx_data_rd(void)
{
	      alt_u16 i,adr;
	      alt_u32 rd_data;
	       adr=0;
		  IOWR_ALTERA_AVALON_PIO_DATA(CPU_RD_RAM_BASE,0x01);// ÔÊÐíCPU¶Ôram¶Á²Ù×÷

		   for (i=0;i<78;i++)
		        {

		          IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_EN_BASE,0x01);
		          IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_ADR_BASE,adr);
		     	  IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_CLK_BASE,0);
		     	  delay(1);
		     	  IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_CLK_BASE,1);
		     	  delay(1);
		     	  rd_data=IORD_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_DATA_BASE);
		     	  SendBuf_long[4*i]=(rd_data>>24)&0xFF;
		     	  SendBuf_long[4*i+1]=(rd_data>>16)&0xFF;
		     	  SendBuf_long[4*i+2]=(rd_data>>8)&0xFF;
		     	  SendBuf_long[4*i+3]=rd_data&0xFF;
			      adr++;
	            }
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RD_RAM_BASE,0x00);// ½ûÖ¹CPU¶Ôram¶Á²Ù×÷
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_EN_BASE,0x00);
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_ADR_BASE,0x00);
		         IOWR_ALTERA_AVALON_PIO_DATA(CPU_RX_RAM_RD_CLK_BASE,0);

		         adr=0;
		     for (i=0;i<1024;i++)
		          {
		            adr++;
		            IOWR_ALTERA_AVALON_PIO_DATA(RD_ADR_BASE,adr);
		         	IOWR_ALTERA_AVALON_PIO_DATA(RD_CLK_BASE,0);
		            delay(1);
		         	IOWR_ALTERA_AVALON_PIO_DATA(RD_CLK_BASE,1);
		         	delay(1);
		         	dma_data=IORD_ALTERA_AVALON_PIO_DATA(RCV_RAM_DATA_BASE);
		         	SendBuf_long[2*i+312]=(dma_data>>8)&0xFF;
		         	SendBuf_long[2*i+313]=dma_data&0xFF;
		          }

		         rd_data=IORD_ALTERA_AVALON_PIO_DATA(REG_TX_END_TIME_BASE);
		         SendBuf_long[2360]=(rd_data>>24)&0xFF;
		         SendBuf_long[2361]=(rd_data>>16)&0xFF;
		         SendBuf_long[2362]=(rd_data>>8)&0xFF;
		         SendBuf_long[2363]=rd_data&0xFF;
		         rd_data=IORD_ALTERA_AVALON_PIO_DATA(REG_SYN_START_TIME_BASE);
		         SendBuf_long[2364]=(rd_data>>24)&0xFF;
		         SendBuf_long[2365]=(rd_data>>16)&0xFF;
		         SendBuf_long[2366]=(rd_data>>8)&0xFF;
		         SendBuf_long[2367]=rd_data&0xFF;
		         rd_data=IORD_ALTERA_AVALON_PIO_DATA(REG_SYN_ERR_TIME_BASE);
		         SendBuf_long[2368]=(rd_data>>24)&0xFF;
		         SendBuf_long[2369]=(rd_data>>16)&0xFF;
		         SendBuf_long[2370]=(rd_data>>8)&0xFF;
		         SendBuf_long[2371]=rd_data&0xFF;
		         rd_data=IORD_ALTERA_AVALON_PIO_DATA(REG_SYN_TRUE_TIME_BASE);
		         SendBuf_long[2372]=(rd_data>>24)&0xFF;
		         SendBuf_long[2373]=(rd_data>>16)&0xFF;
		         SendBuf_long[2374]=(rd_data>>8)&0xFF;
		         SendBuf_long[2375]=rd_data&0xFF;
		         rd_data=IORD_ALTERA_AVALON_PIO_DATA(REG_DEMAP_END_TIME_BASE);
		         SendBuf_long[2376]=(rd_data>>24)&0xFF;
		         SendBuf_long[2377]=(rd_data>>16)&0xFF;
		         SendBuf_long[2378]=(rd_data>>8)&0xFF;
		         SendBuf_long[2379]=rd_data&0xFF;


		         if (wr_flag==0)
		         	 {
		         		  wr_flag=1;
		         		  uart_long=1;
		                  IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf_long[0]);
		                  SendBuf_long[0]=1;
		                  send_ptr_long++;
		                  uart_init();
		         	 }

}


void config_9866(void)
{
	delay(10);
	IOWR_ALTERA_AVALON_PIO_DATA(RX_GAIN_BASE,0x0F);
	IOWR_ALTERA_AVALON_PIO_DATA(CPU_9866_RECFG_BASE,0x00);
	IOWR_ALTERA_AVALON_PIO_DATA(CPU_9866_RECFG_BASE,0x01);
	IOWR_ALTERA_AVALON_PIO_DATA(CPU_9866_RECFG_BASE,0x00);

}
/*
void rcv_ram_rd(void)
{
	             alt_u16 i,adr;

	             adr=0;
                 for (i=0;i<1024;i++)
                 {
                	 adr++;
                	 IOWR_ALTERA_AVALON_PIO_DATA(RD_ADR_BASE,adr);
		             IOWR_ALTERA_AVALON_PIO_DATA(RD_CLK_BASE,0);
		             delay(1);
		             IOWR_ALTERA_AVALON_PIO_DATA(RD_CLK_BASE,1);
		             delay(1);
		             dma_data=IORD_ALTERA_AVALON_PIO_DATA(RCV_RAM_DATA_BASE);
		             SendBuf_long[2*i]=(dma_data>>8)&0xFF;
		             SendBuf_long[2*i+1]=dma_data&0xFF;
                 }

			  	 if ((wr_flag==0))
		 	      {
		 	   	    wr_flag=1;
		 	   	    uart_long=1;
		 	    	IOWR_ALTERA_AVALON_UART_TXDATA(UART_BASE, SendBuf_long[0]);
		 	    	SendBuf_long[0]=0;
		 	    	send_ptr_long++;
		 	    	uart_init();
		 	      }




}
*/
void data_rcv_isr (void* context,alt_u32 id)
{


	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(CPU_RX_RAM_RD_TRIGER_BASE,0x00);
	/**********************************LED TEST*********************************************/

	 IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x01);
    /*************************************************************************************************/

	     rx_data_rd();


	         if (m_s==0)
	         {
	        	 //Æô¶¯Âß¼­·¢ËÍ×´Ì¬
	        	IOWR_ALTERA_AVALON_PIO_DATA(CPU_TX_TRIGER_BASE,0x00);
	        	IOWR_ALTERA_AVALON_PIO_DATA(CPU_TX_TRIGER_BASE,0x01);
	        	IOWR_ALTERA_AVALON_PIO_DATA(CPU_TX_TRIGER_BASE,0x00);

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
 cnt=0;
 i=0;
 m_s=0;


 alt_irq_register(CPU_RX_RAM_RD_TRIGER_IRQ, (void*)&pio_iq_capture, data_rcv_isr);

 alt_irq_register(UART_IRQ, (void*)&uart_iq_capture, uart_rx_tx_isr);


    IOWR_ALTERA_AVALON_PIO_DATA(LED_FOR_TEST_BASE, 0x00);
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(CPU_RX_RAM_RD_TRIGER_BASE,0xFF);
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(CPU_RX_RAM_RD_TRIGER_BASE,0x00);


	xmt_ram_wr();//Ð´XMT ram
    xmt_ram_rd();
    config_9866();
    //uart_init();



while(1)
 {

	//IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_BASE,0x0A5A5A5A);
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








