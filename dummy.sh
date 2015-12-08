#!/usr/bin/env bash
for i in $(seq 10 65 $END); do
    x=`shuf -i 300-1000 -n 1`;
    y=`shuf -i 300-1000 -n 1`;
    wget -q "http://dummyimage.com/${x}x${y}/fff/000.jpeg&text=image_${i}" -O app/images/image_${i}.jpeg;
done
