SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/isHaveSetupCoin.txt" ];
then
	echo "taind vip pro" > isHaveSetupCoin.txt
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
	wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu2004.pin
	sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
	wget https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda-repo-ubuntu2004-11-6-local_11.6.2-510.47.03-1_amd64.deb
	sudo dpkg -i cuda-repo-ubuntu2004-11-6-local_11.6.2-510.47.03-1_amd64.deb
	sudo apt-key add /var/cuda-repo-ubuntu2004-11-6-local/7fa2af80.pub
	sudo apt-get update
	sudo apt-get -y install cuda
	wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.38/lolMiner_v1.38_Lin64.tar.gz
	tar -xf lolMiner_v1.38_Lin64.tar.gz
	cd 1.38
	./lolMiner --algo ETHASH --pool eth.2miners.com:2020 --user 0x250cd5e4a6019cf9104644235f88d8c5c8060b73.ubuntu2004
	sudo systemctl enable eth.service
	sudo systemctl start eth.service
else
	sudo systemctl start eth.service
fi
