
rm new_jb_rd.img
cd root
find . | cpio -o -H newc | gzip > ../new_jb_rd.img
cd ..
rm boot.img
/root/bin/mkbootimg --cmdline 'console=ttymxc0,115200 init=/init video=mxcfb0:dev=hdmi,1920x1080M@60,if=RGB24,bpp=32 video=mxcfb1:off video=mxcfb2:off fbmem=28M vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale' --kernel jb-zImage --ramdisk new_jb_rd.img -o boot.img
