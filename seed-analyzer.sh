#!/usr/bin/env bash

# Configure script behavior and environment
set -e
shopt -s nullglob
export LC_ALL=C

# Configurable options
profile=(HxPx HxP1 HxP0 H3P0 H2P0 H1P0 DSuf DDom DSub DPth DQry DIni)
weight=(2.00 1.00 0.50 0.10 0.05 0.01)

# CLI arguments with defaults and their derivatives
coll=${1:-COVID19}
seeddir=${2:-seeds}
outdir=${3:-derivatives}
outprefix=$outdir/$coll

# Define a utility function to log on STDERR
log() {
    dt=$(date '+%Y/%m/%d %H:%M:%S.%N')
    printf "[$dt] %s\n" "$*" >&2
}

log "Creating output directory (if missing): $outdir"
mkdir -p $outdir
log "Removing any $coll files from the output directory: $outdir/$coll*"
rm -rf $outprefix-*

# Copy collection seed files and identify sources
src=()
for f in $seeddir/$coll-*.txt
do
    s=$(echo $f | sed "s|$seeddir/$coll-\(.*\)\.txt|\1|")
    opf=$outprefix-$s.SEED
    log "Copying seed file: $f -> $opf"
    cp $f $opf
    src+=($s)
done

# Merge if more than one collection seed files
if (( ${#src[@]} > 1 ))
then
    s=MERGED
    opf=$outprefix-$s.SEED
    log "Merging all seed files: $opf"
    cat $seeddir/$coll-*.txt > $opf
    src+=($s)
fi

# Generate derived files
for s in ${src[@]}
do
    opfn=$outprefix-$s

    log "Generating: $opfn.URIR"
    sort -u $opfn.SEED > $opfn.URIR
    log "Generating: $opfn.SURT"
    scripts/surter.py $opfn.URIR | sort -u > $opfn.SURT

    # Varants based on URI profiling policies
    for p in ${profile[@]}
    do
        log "Generating: $opfn.$p"
        scripts/uri_key_generator.py $p $opfn.URIR | sed 's|[,)/*]\+$||' | sort -u > $opfn.$p
    done

    # Varants based on URI rollup weights
    for w in ${weight[@]}
    do
        log "Generating: $opfn.W$w"
        scripts/mementomap.py $opfn.mm $w $opfn.SURT
        cut -d' ' -f 1 $opfn.mm | sed 's|[,)/*]\+$||' | sort -u > $opfn.W$w
        rm $opfn.mm
    done
done

log "Analyzing derived files to report summary"
echo -n "Variant"
for s in ${src[@]}
do
    echo -ne "\t$s-Lines\t$s-Bytes\t$s-Gzip"
done
echo

# Combine all variants and iterate over to summarize them
variant=(SEED URIR SURT ${profile[@]} ${weight[@]/#/W})
for v in ${variant[@]}
do
    echo -n $v
    for s in ${src[@]}
    do
        opf=$outprefix-$s.$v
        read l w c f <<< $(wc $opf)
        z=`gzip -c $opf | wc -c`
        echo -ne "\t$l\t$c\t$z"
    done
    echo
done

log "All done!"
