#!/bin/bash

cat > /etc/profile << "EOF"
# Begin /etc/profile

export TZ=value_of_$TIMEZONE

for i in $(locale); do
  unset ${i%=*}
done

if [[ "$TERM" = linux ]]; then
  export LANG=C.UTF-8
else
  export LANG=en_US.ISO-8859-1
fi

# End /etc/profile
EOF
