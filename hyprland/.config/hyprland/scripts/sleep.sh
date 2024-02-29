exec chayang && swayidle -w \
         timeout 3600 'systemctl suspend' \
         before-sleep 'swaylock -f -c 000000'

