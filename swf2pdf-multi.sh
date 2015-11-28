function show_help ()
{
	echo 'usage'
	echo "$0 [-o out.pdf] *.swf"
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

echo "verbose=$verbose, output_file='$output_file'"
#exit

mkdir -p /tmp/swf2pdf
pushd /tmp/swf2pdf
rm -f *.pdf
for i in $@; do
	echo "Processing $i"
	swf2pdf "$i"
done
popd
pdfunite /tmp/swf2pdf/*.pdf "$output_file"