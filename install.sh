#!/bin/bash
default_install_dir="/usr/local/bin"
install_dir=""
swftools_archive="swftools-2013-04-09-1007.tar.gz"

function show_help()
{
	echo 'usage'
	echo "$0 [-i install-location]"
	echo "default location: ${default_install_dir}"
}

# Gentoo swftools package is not up-to-date
# only snapshot has -r argument
function install_swfrender()
{
	wget "http://www.swftools.org/${swftools_archive}" &&
	mkdir -p swftools &&
	mv "${swftools_archive}" swftools &&
	pushd swftools
	tar zxvf "${swftools_archive}" --strip 1 &&
		./configure && 
		cd lib && make libbase.a && cd ../src && 
		make swfrender && sudo cp swfrender "${install_dir}"
		make swfdump && sudo cp swfdump "${install_dir}"
	popd
}

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file=""
verbose=0

while getopts "h?vi:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    i)  install_dir="$OPTARG"
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift
### END OPTARGS
if [ -z "$install_dir" ] ; then
	install_dir="${default_install_dir}"
fi

if [ ! -d "${install_dir}" ] ; then
	echo "path \"${install_dir}\" does not exist!! quitting.."
	exit 1
fi

echo "install dir: $install_dir"

if hash swfrender 2>/dev/null ; then
    echo 'pre-existing swftools detected. Checking for -r support'
    ## check for prior existence of swfrender with -r support
	if swfrender | grep -- '-r' > /dev/null 2>&1; then
		echo "swfrender has -r support!"
	else
		echo "swfrender does not have -r support..."
		echo "Figure that ish yourself!"
		echo "Here's what I recommend: convert swf2pdf to bash"
		echo "compile the new swfrender and install as swfrender2"
		echo "have a config file that has env variable for swfrender to use"
		exit 1
	fi
else
    echo 'swfrender not detected.. installing'
    echo 'if you have trouble compiling swftools, such as:'
	echo '#error "no way to define 64 bit integer", then do "sudo ldconfig"'
    install_swfrender
fi

#git clone https://github.com/Hacksign/BaiduDoc.git
pushd BaiduDoc
	make && sudo cp doc "${install_dir}/dl-baidu-swf"
popd

#git clone https://github.com/zyp001a/swf2pdf
pushd swf2pdf
	sudo cp swf2pdf "${install_dir}"
popd

sudo cp swf2pdf-multi.sh "${install_dir}"
sudo cp dl-baidu-pdf.sh "${install_dir}"