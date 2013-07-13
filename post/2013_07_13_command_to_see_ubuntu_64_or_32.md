--filename: 2013_07_13_command_to_see_ubuntu_64_or_32.md
--version: 1.0

## 查看Ubuntu系统是否64位


1.$uname -a

如果有x86_64就是64位的，没有就是32位的


'''
vincent@ubuntu:~$ uname -a 

Linux ubuntu 3.2.0-23-generic-pae #36-Ubuntu SMP Tue Apr 10 22:19:09 UTC 2012 i686 i686 i386 GNU/Linux
'''

2.$ uname -m

x86_64

'''
vincent@ubuntu:~$ uname -m

i686
'''

3.$ arch

x86_64

'''
vincent@ubuntu:~$ arch

i686
'''

4.$file /bin/cat

/bin/cat: ELF 64-bit LSB executable, AMD x86-64, version 1 (SYSV), for GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped

'''
vincent@ubuntu:~$ file /bin/cat 

/bin/cat: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0x9e7f078dcc2d3dae02f578a1390debea06a26b74, stripped
'''

5.查看cpu是多少位的

more /proc/cpuinfo

'''
vincent@ubuntu:~$ more /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 44
model name      : Intel(R) Xeon(R) CPU           E5606  @ 2.13GHz
stepping        : 2
microcode       : 0x10
cpu MHz         : 2128.070
cache size      : 8192 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 11
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss nx rdt
scp constant_tsc up pebs bts xtopology tsc_reliable aperfmperf pni pclmulqdq ssse3 sse4_1 sse4_2 popcnt aes hypervisor arat epb dts
bogomips        : 4256.14
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management:
'''

6. file /sbin/init

/sbin/init: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV),

'''
vincent@ubuntu:~$ file /sbin/init
/sbin/init: ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0x0ec7a63bbdb983cd488002f4cb87cdc0de5596f8, stripped
'''

EOF.
