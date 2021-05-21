pushd
try {
	cd ..
	cd chia-blockchain

	git fetch
	git checkout latest
	git reset --hard FETCH_HEAD

	# If you get RELEASE.dev0 then delete the package-lock.json in chia-blockchain-gui and install.sh again

	git status

	# git status should say "nothing to commit, working tree clean",
	# if you have uncommitted changes, RELEASE.dev0 will be reported.

	sh install.sh
}
finally {
	popd
}
