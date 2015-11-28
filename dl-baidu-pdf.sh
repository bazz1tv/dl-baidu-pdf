#!/bin/bash
function show_help ()
{
	echo 'usage'
	echo "$0 [-o out.pdf] baidu-url"
}

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file="out.pdf"
verbose=0

while getopts "h?o:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    o)  output_file="$OPTARG"
        ;;
    esac
done

#if [ "$output_file" = "" ]; then
#	show_help
#	exit 0
#fi

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

if [ $# -eq 0 ]; then
	show_help
	exit 1
fi

tmpdir="`mktemp -d`" # mkdir -p /tmp/dl-baidu-pdf
echo "using tmpdir: $tmpdir"
pushd "$tmpdir"
rm -f *.swf
dl-baidu-swf "$1"
popd

swf2pdf-multi.sh -o "$output_file" "$tmpdir/*.swf"


