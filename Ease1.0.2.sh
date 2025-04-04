#!/bin/bash

tput setaf 11;
echo -e "Starting the Eigen3, GSL Installation Process ...\n"
echo -e "Make sure, the system is connected to Internet\n"
echo -e "Testing Connectivity ...\n"
if ping -v -c 10 -W 1 0.0.0.0 1>/dev/null;
then
tput setaf 10; echo "Connection is ON"
else
tput setaf 9; echo "Connecting is OFF"
exit 0
fi
tput sgr0;
parent="`pwd`"

##########
# Eigen3 #
##########
version="3.4.0"
url="https://gitlab.com/libeigen/eigen/-/archive/$version/eigen-$version.tar.gz"
FInt="eigen-$version"
File="$FInt.tar.gz"

tput setaf 48; echo -e "\nThe Parent Path of Eigen3 would be :: "`pwd` "\n"
base="$parent/Eigen-$version"
if [ -d $base ]; 
then 
tput setaf 48; echo -e "Parent directory is there :: " $base "\n"
else
mkdir -p $base
tput setaf 50; echo -e "We have just created a Parent directory for Eigen3 :: " $base "\n" 
fi

src="$base/eigen-$version-source"
if [ -d $src ]; 
then 
tput setaf 48; echo -e "Eigen3 Source directory is there :: " $src "\n"
else
mkdir -p $src
tput setaf 50; echo -e "We have just created a Source directory for Eigen3 :: " $src "\n"
fi

dFile="$src/$File"
if [ -f $dFile ]; 
then
tput setaf 48; echo -e "Eigen3 Source File is there :: " $dFile "\n"
else
tput setaf 10; echo -e "We do not find the Source for Eigen$version at :: " $src "\n"
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
tput setaf 50; echo -e "We have just downloaded the Source File for Eigen$version :: " $File "\n"
echo -e "\n"
else
tput setaf 9; echo -e "Could not connect to $url"
exit 1 
echo -e "\n"
fi
fi

build="$base/eigen-$version-build"
if [ -d $build ];
then 
tput setaf 48; echo -e "Eigen3 Build directory is there :: " $build "\n"
else
mkdir -p $build
tput setaf 50; echo -e "We have just created a Build directory for Eigen3 :: " $build "\n"
fi

Install="$base/eigen-$version-install"
if [ -d $Install ];
then 
tput setaf 48; echo -e "Eigen3 Install directory is there :: " $Install "\n"
else
mkdir -p $Install
tput setaf 50; echo -e "We have just created an Install directory for Eigen3 :: " $Install "\n"
fi


cd $src
if [ -f $FInt ]; 
then
tput setaf 48; echo -e "Eigen3 Source File is already Extracted :: " `ls` $src "\n"
else
tput setaf 50; echo -e "Untarring the $FInt\n"
fi
tput sgr0;
tar -zxvf $File
echo
tput setaf 50; echo -e "We have untarred the $File\n\n"

cd $build
tput setaf 50; echo -e "Now, building $FInt with C++11 ...\n"
tput sgr0;
cmake -DCMAKE_INSTALL_PREFIX=$Install -DEIGEN_TEST_CXX11=ON $src/$FInt
echo
if [ -f "Makefile" ];
then
tput setaf 48; echo -e "Installing ...\n"
make install -j4
else
tput setaf 9; echo -e "Something gone wrong, during Building!\n"
exit 2
fi

Include="$Install/include"
if [ -d $Include ];
then
echo 
tput setaf 48; echo -e "$FInt is successfully installed at :: " $Install "\n"
else
echo -e "Something gone worng, during Installation!\n"
fi


Env="$base/$FInt-env.sh"
cd $base
echo
if [ -f $Env ];
then
tput setaf 48; echo -e "An environment file for \"$Install\" is already exist!\n"
else
tput setaf 50; echo -e "Creating an environment file for the installed $Install ...\n"
touch $Env
echo "#!/bin/bash" > $Env
echo "" >> $Env
echo "#$FInt" >> $Env
echo "" >> $Env
echo "export EIGEN_INCLUDE_DIR=$Include" >> $Env
echo "" >> $Env
echo "#$FInt" >> $Env
fi
cd $parent
###########
# GSL-2.8 #
###########
version="2.8"
url="https://mirror.ibcp.fr/pub/gnu/gsl/gsl-$version.tar.gz"
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
make -j$(($(nproc)-1))
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

Env="$base/$FInt-env.sh"
cd $base
echo
if [ -f $Env ];
then
tput setaf 48; echo -e "An environment file for \"$Install\" is already exist!\n"
else
tput setaf 50; echo -e "Creating an environment file for the installed $Install ...\n"
touch $Env
echo "#!/bin/bash" > $Env
echo "" >> $Env
echo "#$FInt" >> $Env
echo "" >> $Env
echo "export GSL_ROOT_DIR=$Install" >> $Env
echo "export GSL_INCLUDE_DIR=\$GSL_ROOT_DIR/include" >> $Env
echo "export GSL_LIBRARY_DIR=\$GSL_ROOT_DIR/lib" >> $Env
echo "export PATH=\$GSL_ROOT_DIR/bin:\$PATH" >> $Env
echo "export LD_LIBRARY_PATH=\$GSL_ROOT_DIR/lib:\$LD_LIBRARY_PATH" >> $Env
echo "" >> $Env
echo "#$FInt" >> $Env
fi
cd $parent

# Done! #
tput setaf 48; echo -e "Installations are Done!"
echo -e "Source the Environment File(s) and Enjoy your Work."
echo -e "Cheers!!!\n\n"
