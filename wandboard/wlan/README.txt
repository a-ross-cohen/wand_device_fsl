[Build driver]
1. #cd bcmdhd
2. #vim PeterMake.sh
   (a) change KERNEL_PATH, My_ARCH, and My_CROSS_COMPILE to your own path
3. #./PeterMake.sh
4. If success, you will get driver "bcmdhd.ko"

[Insmod driver on your platform]
1. #./on.sh
