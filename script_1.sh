if [ "$#" -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

while getopts "f:e:" opt; do
    case "$opt" in
    f)
        filename="$OPTARG"
        ;;
    e)
        new_extension="$OPTARG"
        ;;
    *)
        exit 1
        ;;
    esac
done

if [ -z $filename ]; then
    echo "You haven't set the filename"
    exit 2
fi

filename_without_extension="${filename%.*}"

mv $filename "$filename_without_extension.$new_extension"

echo done