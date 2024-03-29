# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/fsl/imx6/imx6_wand.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

ifneq ($(wildcard device/fsl/wandboard/fstab_nand.freescale),)
$(shell touch device/fsl/wandboard/fstab_nand.freescale)
endif

ifneq ($(wildcard device/fsl/wandboard/fstab.freescale),)
$(shell touch device/fsl/wandboard/fstab.freescale)
endif

# Overrides
PRODUCT_NAME := wandboard
PRODUCT_DEVICE := wandboard

PRODUCT_COPY_FILES += \
	device/fsl/wandboard/required_hardware.xml:system/etc/permissions/required_hardware.xml \
	device/fsl/wandboard/init.wandboard.rc:root/init.wandboard.rc \
	device/fsl/wandboard/gpsreset.sh:system/etc/gpsreset.sh \
	device/fsl/wandboard/audio_policy.conf:system/etc/audio_policy.conf \
	device/fsl/wandboard/audio_effects.conf:system/vendor/etc/audio_effects.conf

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/fsl/wandboard/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml
#	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \

# for PDK build, include only when the dir exists
# too early to use $(TARGET_BUILD_PDK)
ifneq ($(wildcard packages/wallpapers/LivePicker),)
PRODUCT_COPY_FILES += \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
endif

PRODUCT_COPY_FILES += \
	device/fsl/wandboard/firmware/brcm/bcm4329_fw.bin:system/etc/firmware/brcm/bcm4329_fw.bin \
	device/fsl/wandboard/firmware/brcm/bcm4329_nvram.txt:system/etc/firmware/brcm/bcm4329_nvram.txt \
	device/fsl/wandboard/firmware/brcm/bcm4329.hcd:system/etc/firmware/brcm/BCM4329B1.hcd \
	device/fsl/wandboard/firmware/brcm/bcm4330_fw.bin:system/etc/firmware/brcm/bcm4330_fw.bin \
	device/fsl/wandboard/firmware/brcm/bcm4330_nvram.txt:system/etc/firmware/brcm/bcm4330_nvram.txt \
	device/fsl/wandboard/firmware/brcm/bcm4330.hcd:system/etc/firmware/brcm/BCM4330B1.hcd \
	device/fsl/wandboard/rc.wifi:system/bin/wifi/rc.wifi

PRODUCT_COPY_FILES += \
	device/fsl/wandboard/media_profiles_480p.xml:system/etc/media_profiles.xml
# Bluetooth support
PRODUCT_COPY_FILES += \
        system/bluetooth/data/main.nonsmartphone.conf:system/etc/bluetooth/main.conf

PRODUCT_COPY_FILES += \
    device/fsl/wandboard/boot/uEnv.txt:boot/uEnv.txt