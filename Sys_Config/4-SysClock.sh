#!/bin/bash

cat >/etc/rc.d/init.d/setclock <<"EOF"
#!/bin/bash
# Begin $rc_base/init.d/setclock - Setting Linux Clock

# Based on setclock script from LFS-3.1 and earlier.
# Rewritten by Gerard Beekmans  - gerard@linuxfromscratch.org
# Rewritten by Marc Heerdink to include writing to the hardware clock
# Rewritten by Archaic <archaic@remove-this.indy.rr.com> to conform to
# lfs-bootscripts-1.11

source /etc/sysconfig/rc
source $rc_functions
source /etc/sysconfig/clock

case "$1" in
     start)
          case "$UTC" in
               yes|true|1)
                    echo "Setting system clock..."
                    hwclock --hctosys --utc
                    evaluate_retval
                    ;;

               no|false|0)
                    echo "Setting system clock..."
                    hwclock --hctosys --localtime
                    evaluate_retval
                    ;;

               *)
                    echo "Invalid value for UTC in /etc/sysconfig/clock: $UTC"
                    echo "Valid values for UTC are 1 and 0."
                    exit 1
                    ;;
          esac
          ;;

     stop)
          case "$UTC" in
               yes|true|1)
                    echo "Updating hardware clock..."
                    hwclock --systohc --utc
                    evaluate_retval
                    ;;

               no|false|0)
                    echo "Updating hardware clock..."
                    hwclock --systohc --localtime
                    evaluate_retval
                    ;;

               *)
                    echo "Invalid value for UTC in /etc/sysconfig/clock: $UTC"
                    echo "Valid values for UTC are 1 and 0."
                    exit 1
                    ;;
          esac
          ;;

     *)
          echo "Usage: $0 {start|stop}"
          exit 1
          ;;
esac

# End $rc_base/init.d/setclock
EOF

chmod 755 /etc/rc.d/init.d/setclock

ln -s ../init.d/setclock /etc/rc.d/rc0.d/K45setclock &&  ln -s ../init.d/setclock /etc/rc.d/rc6.d/K45setclock

# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
