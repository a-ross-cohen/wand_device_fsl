#!/bin/bash

#export KERNEL_PATH=/home/shlin/Desktop/My_ISSUE/IMX61/imx61_4.2.2/android_jb4.2.2_1.0.0-ga_source/myandroid/kernel_imx
#export My_ARCH=arm
#export My_CROSS_COMPILE=/home/shlin/Desktop/My_ISSUE/IMX61/imx61_4.2.2/android_jb4.2.2_1.0.0-ga_source/myandroid/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-

#export KERNEL_PATH=/media/SSD60G/EZSDK05/imx6/kernel_imx
#export KERNEL_PATH=/media/TroisTB/TOSHIBA_EXT/FSL_LTIB/4.1.0/L3.0.35_4.1.0_130816_source/pkgs/linux-3.0.35
#export KERNEL_PATH=/media/VBOX/tn_edm_imx6_jb2_release_20130906/kernel/linux-3.0.35-edm-imx
#export KERNEL_PATH=/media/TroisTB/TOSHIBA_EXT/FSL/JB3/kernel_imx
export My_ARCH=arm
#export My_CROSS_COMPILE=arm-none-linux-gnueabi-
#export My_CROSS_COMPILE=/media/VBOX/tn_edm_imx6_jb2_release_20130906/jb2_afs/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-

export ATH_ANDROID_ROOT=/media/toshiba/FSL/JB3/

export KERNEL_PATH=$ATH_ANDROID_ROOT/kernel_imx
export My_CROSS_COMPILE=$ATH_ANDROID_ROOT/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-


make
