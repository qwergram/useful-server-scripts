# Instructions Pulled from:
# https://null-byte.wonderhowto.com/how-to/use-cowrie-ssh-honeypot-catch-attackers-your-network-0181600/
# https://www.infragistics.com/community/blogs/b/torrey-betts/posts/what-i-learned-after-using-an-ssh-honeypot-for-7-days

echo "Script for building cowrie honey pot - Norton Pengra"
if [ "$1" = "prebuild" ]; then
	echo "(Sudo Required) Running Prebuild..."
	apt-get install python3-dev
	sleep .5
	echo "Moving Real SSH server"
	nano /etc/ssh/sshd_config
elif [ "$1" = "build" ]; then
	echo "Creating Virtual Environment..."
	python3 -m venv .
	sleep .5
	echo "Pulling Cowrie"
	git clone https://github.com/micheloosterhof/cowrie.git src
	sleep .5
	echo "Activating Virtual Environment"
	source bin/activate
	sleep .5
	echo "Installing/Updating Python Features"
	cd src
	pip install --upgrade pip
	pip install --upgrade -r requirements.txt
	sleep .5
	echo "Copying Configuration files"
	cp cowrie.cfg.dist cowrie.cfg
	sleep .5
	echo "Build Complete! Deactivating Virtual env"
	cd ..
	deactivate
elif [ "$1" = "config" ]; then
	echo "Configuring. Make sure you have run build!"
	sleep 3
	nano src/cowrie.cfg
elif [ "$1" = "start" ]; then
	echo "Are you running as root? Make sure you're not!"
	sleep 2
	echo "Running Cowrie"
	source bin/activate
	src/bin/cowrie start
elif [ "$1" = "stop" ]; then
	echo "Stopping Cowrie"
	sleep .5
	src/bin/cowrie stop
	deactivate
elif [ "$1" = "clean" ]; then
	echo "Cleaning up Cowrie"
	rm -rf src
	echo "Cleaning up Virtual env"
	rm -r bin lib local share include
	rm *.json
	rm *.cfg
	rm lib64
else
	echo "Unknown Command. Your options are as follows:"
	echo "prebuild, build, config, start, stop, clean"
fi

echo "Script Complete!"
