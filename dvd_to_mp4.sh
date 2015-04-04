#!/bin/bash

n=50

for ((i=15;i<=$n;i++)); do
    echo $i;
    i_padded=`printf "%02d" $i`
    echo $i_padded
    sudo HandBrakeCLI -t $i -i /dev/dvd -o lalinea-01-$i_padded.m4v
    #sudo HandBrakeCLI -t $i -i /dev/dvd -o lalinea-02-$i_padded.m4v
done

exit;

for ((i=1;i<=$n;i++)); do
    echo $i;
    i_padded=`printf "%02d" $i`
    echo $i_padded
    sudo HandBrakeCLI -t 1 -c $i -i /dev/dvd -o lalinea-03-$i_padded.m4v
    #sudo HandBrakeCLI -t $i -i /dev/dvd -o lalinea-02-$i_padded.m4v
done


n=5

for ((j=2;j<=$n;j++)); do
    echo $j;
    i=$((25+j))
    i_padded=`printf "%02d" $i`
    echo $i_padded
    #sudo HandBrakeCLI -c $i -i /dev/dvd -o lalinea-02-$i_padded.m4v
    sudo HandBrakeCLI -t $i -i /dev/dvd -o lalinea-03-$i_padded.m4v
done
