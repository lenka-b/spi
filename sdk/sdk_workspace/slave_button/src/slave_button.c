#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xgpiops.h"
#include "xstatus.h"
#include "xil_printf.h"
#include "xspips.h"


#define SPI_DEVICE_0_ID     XPAR_XSPIPS_0_DEVICE_ID
#define SPI_DEVICE_1_ID     XPAR_XSPIPS_1_DEVICE_ID
#define GPIO_DEVICE_ID      XPAR_XGPIOPS_0_DEVICE_ID

#define delay_max 10000000

#define SPI_SELECT  0x0


/*
 * The following constant specify the max amount of data the slave is
 * expecting to receive from the master.
 */
#define MAX_DATA        100


/***************** Macros (Inline Functions) Definitions *********************/

#define SpiPs_RecvByte(BaseAddress) \
        (u8)XSpiPs_In32((BaseAddress) + XSPIPS_RXD_OFFSET)

#define SpiPs_SendByte(BaseAddress, Data) \
        XSpiPs_Out32((BaseAddress) + XSPIPS_TXD_OFFSET, (Data))


/************************** Function Prototypes ******************************/

void SpiSlaveRead(int ByteCount);

void SpiSlaveWrite(u8 *Sendbuffer, int ByteCount);

int SpiPsSlavePolledExample(u16 SpiDeviceId);

static int GpioInputExample(u32 *DataRead);


static u32 Input_Pin;


/************************** Variable Definitions *****************************/

/*
 * The instances to support the device drivers are global such that they
 * are initialized to zero each time the program runs. They could be local
 * but should at least be static so they are zeroed.
 */
static XSpiPs SpiInstance_0;
static XSpiPs SpiInstance_1;
XGpioPs Gpio;


/*
 * The ReadBuffer is used to read to the data which it received from the SPI
 * Bus which master has sent.
 */
u8 ReadBuffer[MAX_DATA];
u8 SentBuffer[MAX_DATA];


/*****************************************************************************
*
* Main function.
*
******************************************************************************/

int main(void)
{

    int Status_0;
    XSpiPs_Config *SpiConfig_0;

    int Status_1;
    XSpiPs_Config *SpiConfig_1;

    int Status;
    u32 InputData;
    volatile int Delay;

    XGpioPs_Config *ConfigPtr;
    int Type_of_board;


    xil_printf("Hi.\r\n");

    memset(ReadBuffer, 0x00, sizeof(ReadBuffer));
    memset(SentBuffer, 0x00, sizeof(SentBuffer));


        /**************************************** Initialisation of SPI_0 **********************************************/

        /*
         * Initialize the SPI driver so that it's ready to use.
         */
        SpiConfig_0 = XSpiPs_LookupConfig(SPI_DEVICE_0_ID);
        if (NULL == SpiConfig_0) {
            return XST_FAILURE;
        }

        Status_0 = XSpiPs_CfgInitialize((&SpiInstance_0), SpiConfig_0,
                        SpiConfig_0->BaseAddress);
        if (Status_0 != XST_SUCCESS) {
            return XST_FAILURE;
        }

        /*
         * The SPI device is a slave by default and the clock phase
         * have to be set according to its master. In this example, CPOL is set
         * to quiescent high and CPHA is set to 1.
         */
        Status_0 = XSpiPs_SetOptions((&SpiInstance_0), (XSPIPS_CR_CPHA_MASK) | \
                (XSPIPS_CR_CPOL_MASK));
        if (Status_0 != XST_SUCCESS) {
            return XST_FAILURE;
        }
        xil_printf("Initialisation is finished.\r\n");


        /*
         * Set the Rx FIFO Threshold to the Max Data.
         */
        XSpiPs_SetRXWatermark((&SpiInstance_0),MAX_DATA);



            /**************************************** Reading **********************************************/




            /**************************************** Initialisation of SPI_1 **********************************************/

        /*
         * Initialize the SPI driver so that it's ready to use.
         */
        SpiConfig_1 = XSpiPs_LookupConfig(SPI_DEVICE_1_ID);
        if (NULL == SpiConfig_1) {
            return XST_FAILURE;
        }

        Status_1 = XSpiPs_CfgInitialize((&SpiInstance_1), SpiConfig_1,
                        SpiConfig_1->BaseAddress);
        if (Status_1 != XST_SUCCESS) {
            return XST_FAILURE;
        }

        XSpiPs_SetOptions(&SpiInstance_1, XSPIPS_MASTER_OPTION |
                       XSPIPS_FORCE_SSELECT_OPTION);
        xil_printf("Initialisation is finished.\r\n");


        XSpiPs_SetClkPrescaler(&SpiInstance_1, XSPIPS_CLK_PRESCALE_64);
        xil_printf("Clock is set.\r\n");


        /*
         * Assert the EEPROM chip select.
         */
        XSpiPs_SetSlaveSelect(&SpiInstance_1, SPI_SELECT);
        xil_printf("Slave is selected.\r\n");



        /**************************************** Initialisation of GPIO **********************************************/

        Type_of_board = XGetPlatform_Info();
        switch (Type_of_board) {
            case XPLAT_ZYNQ_ULTRA_MP:
                Input_Pin = 22;
                break;

            case XPLAT_ZYNQ:
                Input_Pin = 51;
                break;
        }

        ConfigPtr = XGpioPs_LookupConfig(GPIO_DEVICE_ID);
        Status = XGpioPs_CfgInitialize(&Gpio, ConfigPtr,
                        ConfigPtr->BaseAddr);
        if (Status != XST_SUCCESS) {
            return XST_FAILURE;
        }
        xil_printf("Enabled.\r\n");
        /*
         * Enable the device.
         */
        XSpiPs_Enable((&SpiInstance_0));

        XSpiPs_Enable((&SpiInstance_1));

        xil_printf("Waiting for read...\r\n");

        SpiSlaveRead(MAX_DATA);

        xil_printf("Reading  %x %x %x %x. \r\n", ReadBuffer[0],  ReadBuffer[1],  ReadBuffer[2],  ReadBuffer[3]);



        /**************************************** Running the Input Example *******************************************/

        do {
            Status = GpioInputExample(&InputData);
            if (Status != XST_SUCCESS) {
                return XST_FAILURE;
            }
        } while (InputData==0);
        xil_printf("Taster passed.\r\n");

        for (Delay=0; Delay<delay_max; Delay++);


            /**************************************** Writing **********************************************/

            for (int i=0; i < MAX_DATA; i++) {
                SentBuffer[i]=ReadBuffer[i];
            }


            SpiSlaveWrite(SentBuffer, MAX_DATA);
            xil_printf("Message is sent. \r\n");


        XSpiPs_Disable((&SpiInstance_0));

        XSpiPs_Disable((&SpiInstance_1));


    xil_printf("End.");

    return XST_SUCCESS;
}


/*****************************************************************************
*
* This function reads from the Rx buffer.
*
******************************************************************************/

void SpiSlaveRead(int ByteCount)
{
    int Count;
    u32 StatusReg;

    	xil_printf("1");
        StatusReg = XSpiPs_ReadReg(SpiInstance_0.Config.BaseAddress,
                        XSPIPS_SR_OFFSET);

        xil_printf("2");
        /*
         * Polling the Rx Buffer for Data.
         */
        do{
            StatusReg = XSpiPs_ReadReg(SpiInstance_0.Config.BaseAddress,
                        XSPIPS_SR_OFFSET);
        }while(!(StatusReg & XSPIPS_IXR_RXNEMPTY_MASK));

        xil_printf("3");
        /*
         * Reading the Rx Buffer.
         */
        for(Count = 0; Count < ByteCount; Count++){
                ReadBuffer[Count] = SpiPs_RecvByte(
                        SpiInstance_0.Config.BaseAddress);
        }
        xil_printf("4");
}


/*****************************************************************************
*
* This function writes Data into the Tx buffer.
*
******************************************************************************/

void SpiSlaveWrite(u8 *Sendbuffer, int ByteCount)
{
    u32 StatusReg;
    int TransCount = 0;


        StatusReg = XSpiPs_ReadReg(SpiInstance_1.Config.BaseAddress,
                    XSPIPS_SR_OFFSET);


        /*
         * Fill the TXFIFO with as many bytes as it will take (or as
         * many as we have to send).
         */
        while ((ByteCount > 0) &&
            (TransCount < XSPIPS_FIFO_DEPTH)) {
                SpiPs_SendByte(SpiInstance_1.Config.BaseAddress,
                        *Sendbuffer);
                Sendbuffer++;
                ++TransCount;
                ByteCount--;
        }
        xil_printf("\rBuffer is filled.\r\n");


        /*
         * Wait for the transfer to finish by polling Tx fifo status.
         */
        do {
            StatusReg = XSpiPs_ReadReg(
                    SpiInstance_1.Config.BaseAddress,
                        XSPIPS_SR_OFFSET);
        } while ((StatusReg & XSPIPS_IXR_TXOW_MASK) == 0);

}


static int GpioInputExample(u32 *DataRead)
{

    /* Set the direction for the specified pin to be input. */
    XGpioPs_SetDirectionPin(&Gpio, Input_Pin, 0x0);

    /* Read the state of the data so that it can be  verified. */
    *DataRead = XGpioPs_ReadPin(&Gpio, Input_Pin);
    /* xil_printf("%x\r\n", *DataRead); */

    return XST_SUCCESS;
}
