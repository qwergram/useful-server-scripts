# https://github.com/NateShoffner/PySnip/blob/master/README.md
if [ "$1" = "build" ]; then
	echo "Building Build And Shoot Server! Script by Norton Pengra"
	echo "Cloning"
	git clone https://github.com/NateShoffner/PySnip server
	echo "Setting up virtual environment"
	cd server
	virtualenv -p python2 .
	source bin/activate
	echo "Downloading dependencies"
	pip install cython twisted jinja2 pillow pygeoip pycrypto pyasn1
	# ./build.sh contents
	echo "Building"
	sh ./build.sh
	deactivate
	cd ..
	echo "Build complete!"
elif [ "$1" = "run" ]; then
	echo "Running server"
	cd server
	source bin/activate
	./run_server.sh
	deactivate
elif [ "$1" = "clean" ]; then
	echo "Cleaning!"
	rm -rf server/
else
	echo "Unknown Command!"
	echo "Available commands are build, run and clean"
fi
