#!/bin/bash
sudo apt-get update -qq;
sudo apt-get install -y aptitude;

if [[ "$ENABLE_IA32" == 1 ]]; then
	sudo apt-get install -y --without-recommends re2c:i386;

	# workaround for  https://bugs.launchpad.net/ubuntu/+source/freetype/+bug/990982
	sudo aptitude install -y libc6-dev libc6-dev:i386;

	sudo aptitude install -y gcc-multilib g++-multilib;
	sudo mv /usr/bin/xml2-config /usr/bin/xml2-config.x86_64;
	sudo aptitude install -y --without-recommends libxml2-dev:i386;
	sudo mv /usr/bin/xml2-config /usr/bin/xml2-config.i386;
	sudo cp /usr/bin/xml2-config.x86_64 /usr/bin/xml2-config;
	# sudo aptitude install -y libicu-dev:i386 # not multiarch ready yet: https://bugs.launchpad.net/ubuntu/+source/icu/+bug/992439
	sudo aptitude install -y --without-recommends zlib1g-dev:i386;
	sudo aptitude install -y --without-recommends libgmp-dev:i386;
	sudo aptitude install -y --without-recommends libmcrypt-dev:i386;
	sudo aptitude install -y --without-recommends libtidy-dev:i386;
	export CFLAGS='-m32';
	export CPPFLAGS='-m32';
	export CCASFLAGS='-m32';
	export LDFLAGS='-m32 -L/lib32';
else
	sudo apt-get install -y --without-recommends re2c;

	sudo aptitude install -y --without-recommends libgmp-dev libicu-dev libmcrypt-dev libtidy-dev;
fi
