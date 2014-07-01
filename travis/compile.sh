#!/bin/bash
if [[ "$ENABLE_MAINTAINER_ZTS" == 1 ]]; then
	TS="--enable-maintainer-zts";
else
	TS="";
fi
if [[ "$ENABLE_DEBUG" == 1 ]]; then
	DEBUG="--enable-debug";
else
	DEBUG="";
fi
if [[ "$ENABLE_IA32" == 1 ]]; then
	sudo apt-get update -qq;
	# work around https://bugs.launchpad.net/ubuntu/precise/+source/libxml2/+bug/987502
	sudo mv /usr/bin/xml2-config /usr/bin/xml2-config.x86_64;
	sudo apt-get install libxml2-dev:i386;
	sudo mv /usr/bin/xml2-config /usr/bin/xml2-config.i386;
	sudo cp /usr/bin/xml2-config.x86_64 /usr/bin/xml2-config;
	sudo ldconfig;
	# end of workaround
        sudo apt-get install -y ia32-libs libc6-i386 gcc-multilib g++-multilib zlib1g-dev:i386;
	export CFLAGS='-m32';
	export CPPFLAGS='-m32';
	export CCASFLAGS='-m32';
	export LDFLAGS='-m32 -L/lib32';
fi

./buildconf --force
./configure --quiet \
$DEBUG \
$TS \
--enable-fpm \
--with-pdo-mysql=mysqlnd \
--with-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-pgsql \
--with-pdo-pgsql \
--with-pdo-sqlite \
--enable-intl \
--without-pear \
--with-gd \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
--enable-exif \
--enable-zip \
--with-zlib \
--with-zlib-dir=/usr \
--with-mcrypt=/usr \
--enable-soap \
--enable-xmlreader \
--with-xsl \
--with-curl=/usr \
--with-tidy \
--with-xmlrpc \
--enable-sysvsem \
--enable-sysvshm \
--enable-shmop \
--enable-pcntl \
--with-readline \
--enable-mbstring \
--with-curl \
--with-gettext \
--enable-sockets \
--with-bz2 \
--with-openssl \
--with-gmp \
--enable-bcmath
make --quiet
