#!/bin/bash

tput setaf 11;
echo -e "Starting the GSL, GLoBES Installation Process ...\n"
echo -e "Make sure, the system is connected to Internet\n"
echo -e "Testing Connectivity ...\n"
if ping -v -c 5 -W 1 google.com 1>/dev/null;
then
tput setaf 10; echo "Connection is ON"
else
tput setaf 9; echo "Connecting is OFF"
exit -1
fi
tput sgr0;
parent="`pwd`"

pkg='autoconf libtool'
if ! dpkg -s $pkg >/dev/null 2>&1;
then
echo
tput setaf 9; echo -e "$pkg, not found! Please do install!\n"
tput setaf 9; echo -e "sudo apt install $pkg\n"
read -p "Do you want to continue without autoconf ? [y/N]" chk
case "$chk" in 
  y|Y ) tput setaf 10; echo "yes";;
    * ) exit 0;;
esac
fi

###########
# GSL-2.8 #
###########

cd $parent
version="2.8"
url="https://ftp.gnu.org/gnu/gsl/gsl-$version.tar.gz"
FInt="gsl-$version"
File="$FInt.tar.gz"

tput setaf 48; echo -e "\nThe Parent Path of GSL would be :: "`pwd` "\n"
base="$parent/GSL-$version"
if [ -d $base ]; 
then 
tput setaf 48; echo -e "Parent directory is there :: " $base "\n"
else
mkdir -p $base
tput setaf 50; echo -e "We have just created a Parent directory for GSL :: " $base "\n" 
fi

src="$base/gsl-$version-source"
if [ -d $src ]; 
then 
tput setaf 48; echo -e "GSL Source directory is there :: " $src "\n"
else
mkdir -p $src
tput setaf 50; echo -e "We have just created a Source directory for GSL :: " $src "\n"
fi

dFile="$src/$File"
if [ -f $dFile ]; 
then
tput setaf 48; echo -e "GSL Source File is there :: " $dFile "\n"
else
tput setaf 10; echo -e "We do not find the Source for GSL$version at :: " $src "\n"
tput setaf 50; echo -e "Connecting to $url" "\n"
echo -e "//================================================================================//\n"
tput sgr0;
wget "${url}"
tput setaf 50;
echo -e "//================================================================================//\n"
mv $File $src
echo -e "\n"
if [ -f $dFile ]; 
then
tput setaf 50; echo -e "We have just downloaded the Source File for GSL$version :: " $File "\n"
echo -e "\n"
else
tput setaf 9; echo -e "Could not connect to $url"
exit 3
echo -e "\n"
fi
fi

build="$base/gsl-$version-build"
if [ -d $build ];
then 
tput setaf 48; echo -e "GSL Build directory is there :: " $build "\n"
else
mkdir -p $build
tput setaf 50; echo -e "We have just created a Build directory for GSL :: " $build "\n"
fi

Install="$base/gsl-$version-install"
if [ -d $Install ];
then 
tput setaf 48; echo -e "GSL Install directory is there :: " $Install "\n"
else
mkdir -p $Install
tput setaf 50; echo -e "We have just created an Install directory for GSL :: " $Install "\n"
fi

cd $src
if [ -f $FInt ]; 
then
tput setaf 48; echo -e "GSL Source File is already Extracted :: " `ls` $src "\n"
else
tput setaf 50; echo -e "Untarring the $FInt\n"
fi
tput sgr0;
tar -zxvf $File
echo
tput setaf 50; echo -e "We have untarred the $File\n\n"

cd $build
tput setaf 50; echo -e "Now, building ...\n"
tput sgr0;
$src/$FInt/configure --prefix=$Install
echo
if [ -f "Makefile" ];
then
tput setaf 48; echo -e "Making ...\n"
make -j4
tput setaf 48; echo -e "Installing ...\n"
make install
else
tput setaf 9; echo -e "Something gone wrong, during Building!\n"
exit 4
fi

Include="$Install/include"
if [ -d $Include ];
then
echo 
tput setaf 48; echo -e "$FInt is successfully installed at :: " $Install "\n"
else
echo -e "Something gone worng, during Installation!\n"
exit 5
fi

gslEnv="$base/$FInt-env.sh"
cd $base
echo
if [ -f $gslEnv ];
then
tput setaf 48; echo -e "An environment file for \"$Install\" is already exist!\n"
else
tput setaf 50; echo -e "Creating an environment file for the installed $Install ...\n"
touch $gslEnv
echo "#!/bin/bash" > $gslEnv
echo "" >> $gslEnv
echo "#$FInt" >> $gslEnv
echo "" >> $gslEnv
echo "export GSL_ROOT_DIR=$Install" >> $gslEnv
echo "export GSL_INCLUDE_DIR=\$GSL_ROOT_DIR/include" >> $gslEnv
echo "export GSL_LIBRARY_DIR=\$GSL_ROOT_DIR/lib" >> $gslEnv
echo "export PATH=\$GSL_ROOT_DIR/bin:\$PATH" >> $gslEnv
echo "export LD_LIBRARY_PATH=\$GSL_ROOT_DIR/lib:\$LD_LIBRARY_PATH" >> $gslEnv
echo "" >> $gslEnv
echo "#$FInt" >> $gslEnv
fi
source $gslEnv

#################
# GLoBES-3.2.16 #
#################
cd $parent
version="3.2.16"
url="https://www.mpi-hd.mpg.de/personalhomes/globes/download/globes-$version.tar.gz"
FInt="globes-$version"
File="$FInt.tar.gz"

tput setaf 48; echo -e "\nThe Parent Path of GLoBES would be :: "`pwd` "\n"
base="$parent/GLoBES-$version"
if [ -d $base ]; 
then 
tput setaf 48; echo -e "Parent directory is there :: " $base "\n"
else
mkdir -p $base
tput setaf 50; echo -e "We have just created a Parent directory for GLoBES :: " $base "\n" 
fi

src="$base/glb-$version-source"
if [ -d $src ]; 
then 
tput setaf 48; echo -e "GLoBES Source directory is there :: " $src "\n"
else
mkdir -p $src
tput setaf 50; echo -e "We have just created a Source directory for GLoBES :: " $src "\n"
fi

dFile="$src/$File"
if [ -f $dFile ]; 
then
tput setaf 48; echo -e "GLoBES Source File is there :: " $dFile "\n"
else
tput setaf 10; echo -e "We do not find the Source for GLoBES-$version at :: " $src "\n"
tput setaf 50; echo -e "Connecting to $url" "\n"
echo -e "//================================================================================//\n"
tput sgr0;
wget "${url}"
tput setaf 50;
echo -e "//================================================================================//\n"
mv $File $src
echo -e "\n"
if [ -f $dFile ]; 
then
tput setaf 50; echo -e "We have just downloaded the Source File for GLoBES-$version :: " $File "\n"
echo -e "\n"
else
tput setaf 9; echo -e "Could not connect to $url"
exit 3
echo -e "\n"
fi
fi

build="$base/glb-$version-build"
if [ -d $build ];
then 
tput setaf 48; echo -e "GLoBES Build directory is there :: " $build "\n"
else
mkdir -p $build
tput setaf 50; echo -e "We have just created a Build directory for GLoBES :: " $build "\n"
fi

Install="$base/glb-$version-install"
if [ -d $Install ];
then 
tput setaf 48; echo -e "GLoBES Install directory is there :: " $Install "\n"
else
mkdir -p $Install
tput setaf 50; echo -e "We have just created an Install directory for GLoBES :: " $Install "\n"
fi

cd $src
if [ -f $FInt ]; 
then
tput setaf 48; echo -e "GLoBES Source File is already Extracted :: " `ls` $src "\n"
else
tput setaf 50; echo -e "Untarring the $FInt\n"
fi
tput sgr0;
tar -zxvf $File
echo
tput setaf 50; echo -e "We have untarred the $File\n\n"

cd $build
tput setaf 50; echo -e "Now, building ...\n"
tput sgr0;
$src/$FInt/configure --prefix=$Install
echo
cd $src/$FInt/
`autoreconf -fi`
cd $build
tput sgr0;
$src/$FInt/configure --prefix=$Install
if [ -f "Makefile" ];
then
tput setaf 48; echo -e "Making ...\n"
make -j4
tput setaf 48; echo -e "Installing ...\n"
make install
else
tput setaf 9; echo -e "Something gone wrong, during Building!\n"
exit 4
fi

Include="$Install/include"
if [ -d $Include ];
then
echo 
tput setaf 48; echo -e "$FInt is successfully installed at :: " $Install "\n"
else
echo -e "Something gone worng, during Installation!\n"
exit 5
fi

glbEnv="$base/$FInt-env.sh"
cd $base
echo
if [ -f $glbEnv ];
then
tput setaf 48; echo -e "An environment file for \"$Install\" is already exist!\n"
else
tput setaf 50; echo -e "Creating an environment file for the installed $Install ...\n"
touch $glbEnv
echo "#!/bin/bash" > $glbEnv
echo "" >> $glbEnv
echo "#$FInt" >> $glbEnv
echo "" >> $glbEnv
echo "export GLoBES_ROOT_DIR=$Install" >> $glbEnv
echo "export GLoBES_INCLUDE_DIR=\$GLoBES_ROOT_DIR/include" >> $glbEnv
echo "export GLoBES_LIBRARY_DIR=\$GLoBES_ROOT_DIR/lib" >> $glbEnv
echo "export PATH=\$GLoBES_ROOT_DIR/bin:\$PATH" >> $glbEnv
echo "export LD_LIBRARY_PATH=\$GLoBES_ROOT_DIR/lib:\$LD_LIBRARY_PATH" >> $glbEnv
echo "" >> $glbEnv
echo "#$FInt" >> $glbEnv
fi
source $glbEnv

# Done! #
tput setaf 48; echo -e "Installations are Done!"
echo -e "Source the Environment File(s) and Enjoy your Work."
echo -e "Cheers!!!\n\n"
exit


