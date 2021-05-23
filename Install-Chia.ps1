pushd
try {
	cd ..
	sudo apt-get update -y
	sudo apt-get upgrade -y

	# Install Git
	sudo apt install git -y

	# Checkout the source and install
	git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
}
finally {
	popd
}
