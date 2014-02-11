# bcmdhd for 43241
# 
# Don't use WL_SCHED_SCAN yet
#
#
#
#
#

DHDCFLAGS = -Wall -Wstrict-prototypes -Dlinux -DBCMDRIVER -DBCMDBG              \
	-DBCMDONGLEHOST -DUNRELEASEDCHIP -DBCMDMA32 -DBCMFILEIMAGE            \
	-DDHDTHREAD -DBDC -DBCMSDIO -DBCMLXSDMMC -DBCMPLATFORM_BUS  \
	-DWIFI_ACT_FRAME -DARP_OFFLOAD_SUPPORT -DDHD_BCMEVENTS -DSHOW_EVENTS                                \
        -DDHD_DEBUG -DSDTEST \
	-DSET_RANDOM_MAC_SOFTAP -DKEEP_ALIVE -DPKT_FILTER_SUPPORT  \

DHDCFLAGS += -DSDIO_ISR_THREAD

DHDCFLAGS += -DPROP_TXSTATUS              \

#	-DTOE                          
#	-DCUSTOMER_HW2 -DOOB_INTR_ONLY -DHW_OOB                               
#	-DMMC_SDIO_ABORT 
#DHDCFLAGS +=  -DWLP2P     \
#	-DGET_CUSTOM_MAC_ENABLE             
#	-DEMBEDDED_PLATFORM -DENABLE_INSMOD_NO_FW_LOAD -DPNO_SUPPORT          \
#	-DDHD_USE_IDLECOUNT -DROAM_ENABLE -DVSDB      
#	-DWL_CFG80211_VSDB_PRIORITIZE_SCAN_REQUEST                            
DHDCFLAGS += -DWLP2P -DESCAN_RESULT_PATCH -DHT40_GO -DPASS_ARP_PACKET -DSDIO_CRC_ERROR_FIX \
	-DDHD_DONOT_FORWARD_BCMEVENT_AS_NETWORK_PKT -DAMPDU_HOSTREORDER       \
	-DCUSTOM_SDIO_F2_BLKSIZE=128 -DSUPPORT_PM2_ONLY	-DWL_SDO\
#	-Idrivers/net/wireless/bcmdhd -Idrivers/net/wireless/bcmdhd/include

DHDOFILES = aiutils.o bcmsdh_sdmmc_linux.o dhd_linux.o siutils.o bcmutils.o   \
	dhd_linux_sched.o dhd_sdio.o bcmwifi_channels.o bcmevent.o hndpmu.o   \
	bcmsdh.o dhd_cdc.o bcmsdh_linux.o dhd_common.o linux_osl.o            \
	bcmsdh_sdmmc.o dhd_custom_gpio.o sbutils.o wldev_common.o wl_android.o



CONFIG_BCMDHD=m
obj-$(CONFIG_BCMDHD) += bcmdhd.o

ifeq ($(KBUILD_SRC),)
DHD_SRC = $(src)
else
DHD_SRC = $(KBUILD_SRC)/$(src)
endif


bcmdhd-objs += $(DHDOFILES)
ifneq ($(CONFIG_WIRELESS_EXT),)
bcmdhd-objs += wl_iw.o
DHDCFLAGS += -DSOFTAP -DWL_WIRELESS_EXT -DUSE_IW
endif
ifneq ($(CONFIG_CFG80211),)
bcmdhd-objs += wl_cfg80211.o wl_cfgp2p.o wl_linux_mon.o dhd_cfg80211.o
DHDCFLAGS += -DWL_CFG80211
#DHDCFLAGS += -DWL_CFG80211_STA_EVENT
DHDCFLAGS += -DWL_ENABLE_P2P_IF
DHDCFLAGS += -DCUSTOM_ROAM_TRIGGER_SETTING=-65
DHDCFLAGS += -DCUSTOM_ROAM_DELTA_SETTING=15
DHDCFLAGS += -DCUSTOM_KEEP_ALIVE_SETTING=28000
DHDCFLAGS += -DCUSTOM_PNO_EVENT_LOCK_xTIME=7
endif
ifneq ($(CONFIG_DHD_USE_SCHED_SCAN),)
DHDCFLAGS += -DWL_SCHED_SCAN
endif
EXTRA_CFLAGS = $(DHDCFLAGS)
ifeq ($(CONFIG_BCMDHD),m)
DHDCFLAGS += -I$(M) -I$(M)/include
EXTRA_LDFLAGS += --strip-debug
endif

#KERNEL_PATH?=/home/shlin//Desktop/My_ISSUE/IMX61/imx-android-13.4.1/myandroid/kernel_imx
#My_ARCH?=arm
#My_CROSS_COMPILE?=/home/shlin/Desktop/My_ISSUE/IMX61/imx-android-13.4.1/myandroid/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

all:
	make -C $(KERNEL_PATH) M=`pwd` ARCH=$(My_ARCH) CROSS_COMPILE=$(My_CROSS_COMPILE) V=1 modules
clean:
	make -C $(KERNEL_PATH) M=`pwd` ARCH=$(My_ARCH) CROSS_COMPILE=$(My_CROSS_COMPILE) clean
	rm *.o
