#! /bin/sh

echo "Step 1: Removing service from /etc/init.d/"
/etc/init.d/atombot disable
/etc/init.d/atombot stop
rm -rf /etc/init.d/atombot

echo "Step 2: Removing service from /usr/lib/systemd/"
/usr/lib/systemd/atombot disable
/usr/lib/systemd/atombot stop
rm -rf /usr/lib/systemd/atombot

echo "Step 3: Removing service from /etc/systemd/system/"
systemctl disable atombot.service
systemctl stop atombot.service
rm -rf /etc/systemd/system/atombot.service

echo "Step 4: Removing forlders of bots older versions"
rm -rf /usr/EY_AtomBot-2.0
rm -rf /usr/EY_AtomBot-2.1
rm -rf /usr/EY_AtomBot-2.3
rm -rf /usr/EY_AtomBot-2.5
rm -rf /usr/ey_atombot_v2.5
rm -rf /usr/ey_atombot_v3.0

echo "Step 5: Installing new version 3.0 bot"
mkdir /usr/ey_atombot_v3.0
cd /tmp/atombot_setup

echo "Step 5a: Extracting package to /usr/ey_atombot_v3.0/"
tar -C /usr/ey_atombot_v3.0/ -zxvf EY_AtomBot-3.0.linux-x86_64.tar.gz

echo "Step 5b: Copying contents of dist to /usr/ey_atombot_v2.5/"
cp /usr/ey_atombot_v3.0/dist/* /usr/ey_atombot_v3.0/
rm -rf /usr/ey_atombot_v3.0/dist/

echo "Step 5c: Copying configDetails.txt and scan_config.json to /usr/ey_atombot_v3.0/"
sudo cp --force configDetails.txt /usr/ey_atombot_v3.0/
sudo cp --force scan_config.json /usr/ey_atombot_v3.0/
chmod -R 755 /usr/ey_atombot_v3.0/

echo "Step 5d: Copying atombot.service to /etc/systemd/system/"
sudo cp --force atombot.service /etc/systemd/system/
chmod 755 /etc/systemd/system/atombot.service

echo "Step 6: Loading daemon atombot.service"
systemctl daemon-reload

echo "Step 6a: Starting atombot.service"
systemctl start atombot.service
systemctl enable atombot.service
systemctl status atombot.service && exit
