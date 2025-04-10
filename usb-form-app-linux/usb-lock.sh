#!/bin/bash
echo "USB skripta pokrenuta $(date)" >> /home/bejdo/Downloads/usb-log.txt

# Umount svih USB diskova
for dev in $(lsblk -o NAME,TRAN | grep usb | awk '{print $1}'); do
  umount /dev/$dev* 2>/dev/null
done

# Pokreni Node server ako nije aktivan
pgrep -f "node /home/bejdo/Downloads/usb-form-app/server.js" > /dev/null
if [ $? -ne 0 ]; then
  echo "Server nije pokrenut. Pokrećem server..." >> /home/bejdo/Downloads/usb-log.txt
  /usr/bin/node /home/bejdo/Downloads/usb-form-app/server.js >> /home/bejdo/Downloads/usb-log.txt 2>&1 &
else
  echo "Server je već pokrenut." >> /home/bejdo/Downloads/usb-log.txt
fi
firefox http://localhost:3000 &

# Otvori formu u browseru
echo "Otvaram browser sa http://localhost:3000" >> /home/bejdo/Downloads/usb-log.txt

