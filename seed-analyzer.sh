#!/usr/bin/env bash

# Exit immediately if anything goes wrong
set -e

# Set locale
export LC_ALL=C

# Define a utility function to log on STDERR
log() {
    dt=$(date '+%Y/%d/%m %H:%M:%S.%N');
    printf "[INFO $dt] %s\n" "$*" >&2
}

# CLI arguments with defaults
coll=${1:-COVID19}
seeddir=${2:-seeds}
opdir=${3:-derivatives}

# Configurable options
src=(MC IIPC Merged)
profile=(HxPx HxP1 H3P0 H1P0 DSuf DDom DSub DPth DQry DIni)
weight=(1.00 0.50 0.10 0.05 0.01)

log "Creating output directory (if missing): $opdir"
mkdir -p $opdir
log "Removing any $coll files from the output directory: $opdir/$coll*"
rm -rf $opdir/$coll*

for s in ${src[@]}
do
    seedf=$seeddir/$coll-$s.txt
    opfn=$opdir/$s

    log "Working on the seed file: $seedf"
    log "Generating: $opfn.SEED"
    cp $seedf $opfn.SEED
    log "Generating: $opfn.URIR"
    sort -u $opfn.SEED > $opfn.URIR
    log "Generating: $opfn.SURT"
    scripts/surter.py $opfn.URIR | sort -u > $opfn.SURT

    for p in ${profile[@]}
    do
        log "Generating: $opfn.$p"
        scripts/uri_key_generator.py $p $opfn.URIR | sed 's|[,)/*]\+$||' | sort -u > $opfn.$p
    done

    for w in ${weight[@]}
    do
        log "Generating: $opfn.W$w"
        scripts/mementomap.py $opfn.mm $w $opfn.SURT
        cut -d' ' -f 1 $opfn.mm | sed 's|[,)/*]\+$||' | sort -u > $opfn.W$w
        rm $opfn.mm
    done
done

log "Analyzing generated files to report summary"

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

log "All done!"
