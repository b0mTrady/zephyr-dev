set up [JLink Software and Documentation package](https://www.segger.com/downloads/jlink/) in mounted volume

dpkg -i JLINK.deb

Run container in priveileged mode to get usb mounted to container from microprocessor 

sudo docker container run -it -v /home/b0mtrady/tools:$HOME --privileged -p 3333:3333 --device=/dev/sdb --rm func4plus1/zephyr-dev

run JLink for HiFive1_RevB: 

/usr/bin/JLinkGDBServer -device FE310 -if JTAG -speed 4000 -port 3333 -nogui
