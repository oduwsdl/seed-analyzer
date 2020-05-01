#!/usr/bin/env bash

opdir="derivatives"
src=(MC IIPC Merged)
profile=(HxPx HxP1 H3P0 H1P0 DDom DSub DPth DQry DIni)
weight=(1.00 0.50 0.10 0.05 0.01)

rm $opdir/*

for s in ${src[@]}
do
    opfn=$opdir/$s

    cp seeds/COVID19-$s.txt $opfn.SEED
    sort -u $opfn.SEED > $opfn.URIR
    scripts/surter.py $opfn.URIR | sort -u > $opfn.SURT

    for p in ${profile[@]}
    do
        scripts/uri_key_generator.py $p $opfn.URIR | sed 's|[,)/*]\+$||' | sort -u > $opfn.$p
    done

    for w in ${weight[@]}
    do
        scripts/mementomap.py $opfn.mm $w $opfn.SURT
        cut -d' ' -f 1 $opfn.mm | sed 's|[,)/*]\+$||' | sort -u > $opfn.W$w
        rm $opfn.mm
    done
done

echo -n "Variant"
for s in ${src[@]}
do
    echo -ne "\t$s-Lines\t$s-Bytes\t$s-Gzip"
done
echo

variant=(SEED URIR SURT ${profile[@]} ${weight[@]/#/W})

for v in ${variant[@]}
do
    echo -n $v
    for s in ${src[@]}
    do
        opf=$opdir/$s.$v
        read l w c f <<< $(wc $opf)
        z=`gzip -c $opf | wc -c`
        echo -ne "\t$l\t$c\t$z"
    done
    echo
done
