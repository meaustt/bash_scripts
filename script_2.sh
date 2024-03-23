gcd() {
    if [ $2 -eq 0 ]; then
        echo "GCD is" $1
    else
        gcd $2 $(($1 % $2))
    fi
}

while true; do
    read -p "Enter two number to calculate their GCD: " var1 var2
    if [ -z "$var1" ]; then
        break
    fi

    if [ -z "$var2" ]; then
        echo "You should provide two numbers"
        continue
    fi

    gcd $var1 $var2
done

echo "bye"