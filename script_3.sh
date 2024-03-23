prefix="$1"

if [ -z $prefix ]; then
    echo "Please, provide PREFIX"
    exit 1
fi

date=$(date '+%Y-%m-%d')
mkdir $date

for i in {1..100}; do
    touch "$date"/"$i"
    echo $((1000 + $RANDOM % 9000)) >>"$date"/"$i"
done

sum1=0
for i in {1..50}; do
    sum1=$(($sum1 + $(cat "$date"/"$i")))
done

sum2=0
for i in {51..100}; do
    sum2=$(($sum2 + $(cat "$date"/"$i")))
done

touch "$date".result

if [ $sum1 -gt $sum2 ]; then
    echo "$sum1 > $sum2" >>"$date".result
else
    echo "$sum1 <= $sum2" >>"$date".result
fi

max_number=0
max_number_filename=''

min_number=10000
min_number_filename=''

for i in {1..100}; do
    n=$(cat "$date"/"$i")
    if [ $n -gt $max_number ]; then
        max_number="$n"
        max_number_filename="$i"
    fi
    if [ $n -lt $min_number ]; then
        min_number="$n"
        min_number_filename="$i"
    fi
done

echo "Min number is $min_number from file $min_number_filename" >>"$date".result
echo "Max number is $max_number from file $max_number_filename" >>"$date".result

archive_dir="$prefix"."$date"
mkdir $archive_dir

for i in {1..100}; do
    mv "$date"/"$i" "$archive_dir"/"$i"
done

mv "$date".result "$archive_dir"/"$date".result

tar -czf "$archive_dir".tar.gz $archive_dir

rm -rf $archive_dir $date