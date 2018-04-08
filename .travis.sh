#!/usr/bin/env bash
export PATH=$PATH:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin

echo ========== custom path ============
echo $PATH
   
# echo ========== touch ============
# echo `which touch`
# which touch
# which sleep
# date
# time

# libtool bug fix for libvorbis
export echo=echo



pre_build_prep()
{
cd ~

sudo pip install certifi -U


# https://www.franzoni.eu/python-requests-ssl-and-insecureplatformwarning/
sudo pip install pyOpenSSL ndg-httpsclient pyasn1 -U

sudo pip install  urllib3 -U
sudo pip install requests -U

git clone -b travis https://github.com/oglops/advancedtomato.git
git clone -b v3.5-140 https://github.com/oglops/advancedtomato-gui.git

sudo ln -s ~/advancedtomato/tools/brcm /opt/brcm

rsync -rpv --ignore-times  ./advancedtomato-gui/*  ./advancedtomato/release/src-rt/router/www/  --exclude .git

# echo ========== upnpevent.c ==========
# head -50 advancedtomato/release/src-rt/router/miniupnpd/upnpevents.c
# head -200 advancedtomato/release/src-rt/router/miniupnpd/Makefile.linux
echo ========== pkg-config --exists uuid ==========
pkg-config pkg-config --exists uuid && echo 1

echo ========== bison ==========
apt-cache showpkg bison

cd ~
wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i bison_2.7.1.dfsg-1_amd64.deb

cd advancedtomato/release/src-rt

# echo ========== pastee ==========
# python $TRAVIS_BUILD_DIR/pastee.py  ./router/mysql/configure.mipsel


# is missing on your system

# cd ~
# wget http://ftp.gnu.org/gnu/automake/automake-1.10.tar.gz
# tar xf automake-1.10.tar.gz
# cd automake-1.10
# sh configure --prefix /usr
# sudo make install

# cd ~
# wget http://ftp.gnu.org/gnu/automake/automake-1.12.tar.gz
# tar xf automake-1.12.tar.gz
# cd automake-1.12
# sh configure --prefix /usr
# sudo make install


# cd ~
# wget http://ftp.gnu.org/gnu/automake/automake-1.8.tar.gz
# tar xf automake-1.8.tar.gz
# cd automake-1.8
# sh configure --prefix /usr
# sudo make install


cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.11.tar.gz
tar xf automake-1.11.tar.gz
cd automake-1.11
sh configure --prefix /usr
make
sudo make install



cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
tar xf automake-1.15.tar.gz
cd automake-1.15
sh configure --prefix /usr
make
sudo make install


cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.13.4.tar.gz
tar xf automake-1.13.4.tar.gz
cd automake-1.13.4
sh configure --prefix /usr
make
sudo make install



# mysql warns for this
cd ~
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.63.tar.gz 
tar xf autoconf-2.63.tar.gz
cd autoconf-2.63
sh configure --prefix /usr
make
sudo  make install

# cd ~
# wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.68.tar.gz 
# tar xf autoconf-2.68.tar.gz
# cd autoconf-2.68
# sh configure --prefix /usr
# sudo  make install



cd ~
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz 
tar xf autoconf-2.69.tar.gz
cd autoconf-2.69
sh configure --prefix /usr
make
sudo  make install



# cd ~
# wget http://gnu.mirror.globo.tech/libtool/libtool-2.4.2.tar.gz
# tar xvf libtool-2.4.2.tar.gz
# cd libtool-2.4.2
# sh configure --prefix=/usr
# sudo  make install


cd ~
wget http://gnu.mirror.globo.tech/libtool/libtool-2.4.6.tar.gz
tar xvf libtool-2.4.6.tar.gz
cd libtool-2.4.6
sh configure --prefix=/usr
make
sudo  make install


# try same version in local travis

echo =========== autotools versions ===========
dpkg -l | grep "autogen\|autoconf\|automake\|libtool"

# official image verions
# =========== autotools versions ===========
# ii  autoconf                           2.69-6                                     all          automatic configure script builder
# ii  autogen                            1:5.18-2ubuntu2                            amd64        automated text file generator
# ii  automake                           1:1.14.1-2ubuntu1                          all          Tool for generating GNU Standards-compliant Makefiles
# ii  libltdl-dev:amd64                  2.4.2-1.7ubuntu1                           amd64        A system independent dlopen wrapper for GNU libtool
# ii  libltdl7:amd64                     2.4.2-1.7ubuntu1                           amd64        A system independent dlopen wrapper for GNU libtool
# ii  libopts25:amd64                    1:5.18-2ubuntu2                            amd64        automated option processing library based on autogen
# ii  libopts25-dev                      1:5.18-2ubuntu2                            amd64        automated option processing library based on autogen
# ii  libtool                            2.4.2-1.7ubuntu1                           amd64        Generic library support script


# local version
# i  autoconf                            2.68-1ubuntu2                                       automatic configure script builder
# ii  autogen                             1:5.12-0.1ubuntu1                                   automated text file generator
# ii  automake                            1:1.11.3-1ubuntu2                                   Tool for generating GNU Standards-compliant Makefiles
# ii  libltdl-dev                         2.4.2-1ubuntu1                                      A system independent dlopen wrapper for GNU libtool
# ii  libltdl7                            2.4.2-1ubuntu1                                      A system independent dlopen wrapper for GNU libtool
# ii  libopts25                           1:5.12-0.1ubuntu1                                   automated option processing library based on autogen
# ii  libopts25-dev                       1:5.12-0.1ubuntu1                                   automated option processing library based on autogen
# ii  libtool                             2.4.2-1ubuntu1                                      Generic library support script


cd ~
wget https://downloads.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz
tar xf libuuid-1.0.3.tar.gz
cd libuuid-1.0.3
sh configure --prefix /usr
# CC=mipsel-uclibc-gcc CXX=mipsel-uclibc-g++ AR=mipsel-uclibc-ar RANLIB=/opt/brcm/hndtools-mipsel-uclibc/bin/mipsel-uclibc-ranlib ./configure --host=mipsel-uclibc-linux --prefix=$HOME/uuid-install
make
sudo  make install

echo ========== pkg-config --exists uuid again==========
pkg-config pkg-config --exists uuid && echo 1


# echo =========== mipsel-uclibc-ranlib ===========
# echo $HOME
# ls -l $HOME/advancedtomato/tools/brcm/hndtools-mipsel-uclibc/bin/mipsel-uclibc-ranlib
# which mipsel-uclibc-ranlib
# echo $PATH


# echo /usr/share/aclocal | sudo tee --append /usr/local/share/aclocal/dirlist

# echo =========== dirlist ===========

# cat /usr/local/share/aclocal/dirlist

echo =========== usr/local/share/aclocal ===========
ls /usr/local/share/aclocal/

echo =========== /usr/share/aclocal ===========
ls /usr/share/aclocal

# sudo ln -sT /usr/share/aclocal  /usr/local/share/aclocal-

}

build_tomato()
{
    echo ======================================
    which cp

    cd ~/advancedtomato/release/src-rt

    echo ======before=========
    pwd
    ls -l router/mysql

    cp -f router/mysql/configure.mipsel router/mysql/configure 

    echo ======after=========
    ls -l router/mysql

    # echo ======/opt/brcm/hndtools-mipsel-uclibc/bin=========
    # ls -l /opt/brcm/hndtools-mipsel-uclibc/bin

    echo ================= uuid-dev =====================
    dpkg-query -L uuid-dev
    echo ================= libuuid1 =====================
    dpkg-query -L libuuid1

    echo ================= uuid =====================
    uname -i
    ls -l /usr/lib64/pkgconfig/
    echo =============== lib =====================
    ls -l /usr/lib/pkgconfig/

    cat /usr/lib/pkgconfig/uuid.pc

    echo =============== grep uuid_generate =====================
    grep uuid_generate /usr/include/uuid/uuid.h

    echo ======== pkg-config calls ========
    # sudo ln -sf /usr/lib/libuuid.so.1 /usr/lib/libuuid.so

    pkg-config --libs-only-L uuid
    pkg-config --version
    pkg-config --print-provides uuid
    pkg-config --help
    pkg-config --path uuid
    pkg-config --static --libs-only-l uuid
    pkg-config --libs-only-l uuid
    pkg-config --libs-only-L uuid
    pkg-config  --cflags uuid
    pkg-config  --static --cflags uuid
    ls -l /usr/include
    echo ================= uuid2 =====================
    # ls -l /usr/include/uuid/
    # ls -l /tt_include 
    # ls -l /tt_lib
    echo ================= uuid lib =====================
    # locate libuuid
    ls -l /usr/lib
    
    echo ================= uuid lib 2 =====================
    # locate libuuid
    ls -l /lib/x86_64-linux-gnu/

    echo ================= uuid lib 3 =====================
    # locate libuuid
    ls -l /lib

    






    # https://bugs.archlinux.org/task/10012

    # cd router/libvorbis
    # libtoolize --force --copy
    # aclocal
    # autoconf
    # automake
    # ./autogen.sh 

    cd ~/advancedtomato/release/src-rt

#     make distclean ; rm ~/advancedTomato.txt;  time make V1=RT-N5x-CN- V2=-140 r2z  2>&1 | tee ~/advancedTomato.txt
#     make distclean
#     rm ~/advancedTomato.txt;  

    # time make V1=RT-N5x-CN- V2=-140 r2z  > ~/advancedTomato.txt

    # make V1=RT-N5x-CN- V2=-140 r2z &
    #make V1=RT-N5x-CN- V2=-140 $TT_BUILD > /dev/null &
    make V1=RT-N5x-CN- V2=-140 $TT_BUILD 


    local build_pid=$!

    # Start a runner task to print a "still running" line every 5 minutes
    # to avoid travis to think that the build is stuck
    {
        while true
        do
            sleep 300
            printf "Crosstool-NG is still running ...\r"
        done
    } &
    local runner_pid=$!

    # Wait for the build to finish and get the result
    wait $build_pid 2>/dev/null 
    local result=$?

    # Stop the runner task
    kill $runner_pid
    wait $runner_pid 2>/dev/null

   echo ====== result =========
   ls -l ~/advancedtomato/release/image
   ls -l ~/advancedtomato/release/src-rt
   ls -l ~/advancedtomato/release/src-rt/image

   ls -l ~/advancedtomato/release/src-rt/wnrtool
   

    # Return the result
    # return $result
    return 0
    



# echo ========== pastee ==========
# python $TRAVIS_BUILD_DIR/pastee.py  -d config.log ./router/libvorbis/config.log
# python $TRAVIS_BUILD_DIR/pastee.py  -d Makefile ./router/libvorbis/Makefile
# python $TRAVIS_BUILD_DIR/pastee.py  -d configure ./router/libvorbis/configure


#     echo ======after make=========
#     ls -l router/mysql
#     echo ======after make=========
#     ls -l 

#     echo ======config.log=========
#     echo `pwd`
#     pwd
#     cat ./router/mysql/config.log

#     echo ======configure.mipsel=========
#     cat ./router/mysql/configure.mipsel

    # echo ======configure=========
    # cat ./router/mysql/configure

    # echo ======config.log=========
    # cat ./config.log    
}
