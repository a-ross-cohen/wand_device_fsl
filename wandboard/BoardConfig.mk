#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6wand.mk
include device/fsl/wandboard/build_id.mk
include device/fsl/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# sabresd_6dq default target for EXT4
BUILD_TARGET_FS ?= ext4
include device/fsl/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_FS),ubifs)
TARGET_RECOVERY_FSTAB = device/fsl/wandboard/fstab_nand.wandboard
# build ubifs for nand devices
PRODUCT_COPY_FILES +=   \
        device/fsl/wandboard/fstab_nand.wandboard:root/fstab.wandboard
else
TARGET_RECOVERY_FSTAB = device/fsl/wandboard/fstab.wandboard
# build for ext4
PRODUCT_COPY_FILES +=   \
        device/fsl/wandboard/fstab.wandboard:root/fstab.wandboard
endif # BUILD_TARGET_FS


TARGET_BOOTLOADER_BOARD_NAME := WANDBOARD
PRODUCT_MODEL := WANDBOARD

BOARD_WLAN_VENDOR := WANDBOARD

ifeq ($(BOARD_WLAN_VENDOR),ATHEROS)
# UNITE is a virtual device support both atheros and realtek wifi(ar6103 and rtl8723as)
BOARD_WLAN_DEVICE            := UNITE
WPA_SUPPLICANT_VERSION       := VER_0_8_UNITE
TARGET_KERNEL_MODULES        := \
                                kernel_imx/drivers/net/wireless/rtl8723as/8723as.ko:system/lib/modules/8723as.ko \
                                kernel_imx/net/wireless/cfg80211.ko:system/lib/modules/cfg80211_realtek.ko
BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

BOARD_HOSTAPD_PRIVATE_LIB_QCOM              := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_QCOM       := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_PRIVATE_LIB_RTL               := lib_driver_cmd_rtl
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RTL        := lib_driver_cmd_rtl
endif
ifeq ($(BOARD_WLAN_VENDOR),WANDBOARD)
BOARD_WLAN_DEVICE                        := bcmdhd
#BOARD_WLAN_DEVICE                        := UNITE
BOARD_WLAN_DEVICE                        := EDM
WPA_SUPPLICANT_VERSION			 := VER_0_8_UNITE
WIFI_DRIVER_MODULE_PATH          	 := "/system/bin/wifi/brcmfmac.ko"
WIFI_DRIVER_MODULE_NAME          	 := "brcmfmac"
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
BOARD_HOSTAPD_DRIVER                     := NL80211
WIFI_TEST_INTERFACE                      := "wlan0"
BOARD_HOSTAPD_PRIVATE_LIB_QCOM              := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_QCOM       := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_PRIVATE_LIB_RTL               := lib_driver_cmd_rtl
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RTL        := lib_driver_cmd_rtl
endif
ifeq ($(BOARD_WLAN_VENDOR),BROADCOM)
BOARD_WLAN_DEVICE                        := bcmdhd
WPA_SUPPLICANT_VERSION			 := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_PRIVATE_LIB                := lib_driver_cmd_bcmdhd
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/bcmdhd.ko"
WIFI_DRIVER_MODULE_NAME                  := "bcmdhd"
WIFI_DRIVER_MODULE_ARG                   := "firmware_path=/system/lib/firmware/bcm4329_fw.bin nvram_path=/system/lib/firmware/bcm4329_nvram.txt iface_name=wlan dhd_msg_level=0"
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
BOARD_HOSTAPD_DRIVER                     := NL80211
WIFI_TEST_INTERFACE                      := "wlan0"
endif

#for intel vendor
ifeq ($(BOARD_WLAN_VENDOR),INTEL)
BOARD_HOSTAPD_PRIVATE_LIB                := private_lib_driver_cmd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
HOSTAPD_VERSION                          := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd_intel
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/iwlagn.ko"
WIFI_DRIVER_MODULE_NAME                  := "iwlagn"
WIFI_DRIVER_MODULE_PATH                  ?= auto
endif

BOARD_MODEM_VENDOR := HUAWEI

USE_ATHR_GPS_HARDWARE := false
USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true
SENSOR_MMA8451 := true

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true

ifeq ($(BOARD_WLAN_VENDOR),WANDBOARD)
TARGET_KERNEL_MODULES := \
   kernel_imx/drivers/net/wireless/brcm80211/brcmfmac/brcmfmac.ko:system/bin/wifi/brcmfmac.ko	\
   kernel_imx/drivers/net/wireless/brcm80211/brcmutil/brcmutil.ko:system/bin/wifi/brcmutil.ko
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/fsl/wandboard/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

#BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=hdmi,1920x1080M@60,if=RGB24,bpp=32 video=mxcfb1:off video=mxcfb2:off fbmem=28M vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=wandboard
BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=hdmi,1280x720M@60,if=RGB24,bpp=32 video=mxcfb1:off video=mxcfb2:off fbmem=28M vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=wandboard
#BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=ldb,bpp=32 video=mxcfb1:off video=mxcfb2:off fbmem=10M fb0base=0x27b00000 vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=wandboard
#BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=lcd,SEIKO-WVGA,if=RGB666,bpp=32 video=mxcfb1:dev=hdmi,1280x720M@60,if=RGB24,bpp=32 video=mxcfb2:off fbmem=8M,12M  vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=wandboard

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

# atheros 3k BT
#BOARD_USE_AR3K_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/fsl/wandboard/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v2
IMX_CAMERA_HAL_V2 := true

# define frame buffer count
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3


TARGET_BOOTLOADER_CONFIG := wandboard_config


