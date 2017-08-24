#!/usr/bin/env bash
export PATH=$PATH:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin

echo ========== custom path ============
echo $PATH
    

# libtool bug fix for libvorbis
export echo=echo



pre_build_prep()
{
cd ~

sudo pip install certifi

git clone -b travis https://github.com/oglops/advancedtomato.git
git clone -b v3.4-140 https://github.com/oglops/advancedtomato-gui.git

sudo ln -s ~/advancedtomato/tools/brcm /opt/brcm

rsync -rpv --ignore-times  ./advancedtomato-gui/*  ./advancedtomato/release/src-rt/router/www/  --exclude .git


cd advancedtomato/release/src-rt

echo ========== pastee ==========
python $TRAVIS_BUILD_DIR/pastee.py  ./router/mysql/configure.mipsel


# is missing on your system

# ==========libvorbis error ==========

cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.10.tar.gz
tar xf automake-1.10.tar.gz
cd automake-1.10
sh configure --prefix /usr
sudo make install

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


# cd ~
# wget http://ftp.gnu.org/gnu/automake/automake-1.11.tar.gz
# tar xf automake-1.11.tar.gz
# cd automake-1.11
# sh configure --prefix /usr
# sudo make install

cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.13.4.tar.gz
tar xf automake-1.13.4.tar.gz
cd automake-1.13.4
sh configure --prefix /usr
sudo make install


cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
tar xf automake-1.15.tar.gz
cd automake-1.15
sh configure --prefix /usr
sudo make install



# cd ~
# wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.63.tar.gz 
# tar xf autoconf-2.63.tar.gz
# cd autoconf-2.63
# sh configure --prefix /usr
# sudo  make install

cd ~
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz 
tar xf autoconf-2.69.tar.gz
cd autoconf-2.69
sh configure --prefix /usr
sudo  make install

cd ~
wget http://gnu.mirror.globo.tech/libtool/libtool-2.4.6.tar.gz
tar xvf libtool-2.4.6.tar.gz
cd libtool-2.4.6
sh configure --prefix=/usr
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





    # https://bugs.archlinux.org/task/10012

    # cd router/libvorbis
    # libtoolize --force --copy
    # aclocal
    # autoconf
    # automake
    # ./autogen.sh 

    cd ~/advancedtomato/release/src-rt

    make distclean ; rm ~/advancedTomato.txt;  time make V1=RT-N5x-CN- V2=-140 r2z  2>&1 | tee ~/advancedTomato.txt


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
