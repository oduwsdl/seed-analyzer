#!/usr/bin/env python3

import locale
import re
import sys
import fileinput

locale.setlocale(locale.LC_ALL, 'C')


def compact(infiter, outfile, hcf=1.0, pcf=1.0, ha=16.329, hk=0.714, pa=24.546, pk=1.429, hdepth=8, pdepth=9, **kw):
    sep = {"host": b",", "path": b"/"}
    maxdepth = {"host": hdepth, "path": pdepth}
    cutoff = {
        "host": [ha * (i+1) ** -hk * hcf for i in range(maxdepth["host"])],
        "path": [pa * (i+1) ** -pk * pcf for i in range(maxdepth["path"])]
    }
    trail = {
        "host": [None]*maxdepth["host"],
        "path": [None]*maxdepth["path"]
    }
    counts = {"inlines": 0, "outlines": 0, "inbytes": 0, "outbytes": 0, "rollups": 0}

    def _gen_keys(str, layer):
        parts = str.strip(sep[layer]).split(sep[layer], maxdepth[layer]-1)
        return [sep[layer].join(parts[:i+1]) for i in range(len(parts))]

    def _init_node(layer, idx):
        trail[layer][idx] = {
            "key": keys[layer][idx],
            "ccount": 0,
            "mcount": freq,
            "optr": opf.tell(),
            "oline": counts["outlines"]
        }
        if idx:
            trail[layer][idx-1]["ccount"] += 1

    def _reset_trail(layer, idx):
        for i in range(idx, maxdepth[layer]):
            if not trail[layer][i]:
                break
            trail[layer][i] = None

    def _compact_subtree(layer, idx):
        compacted = False
        for i in range(idx, maxdepth[layer]):
            if not trail[layer][i]:
                break
            if not i and layer == "host":
                continue
            if trail[layer][i]["ccount"] > cutoff[layer][i]:
                opf.seek(trail[layer][i]["optr"])
                counts["outlines"] = trail[layer][i]["oline"]
                opf.write(trail[layer][i]["key"] + sep[layer] + b"* %d\n" % trail[layer][i]["mcount"])
                counts["outlines"] += 1
                counts["rollups"] += 1
                compacted = True
                break
        _reset_trail(layer, idx)
        if layer == "host":
            if compacted:
                _reset_trail("path", 0)
            else:
                _compact_subtree("path", 0)

    opf = open(outfile, "wb")
    for line in infiter:
        counts["inlines"] += 1
        counts["inbytes"] += len(line)
        if line[0] == b"!":
            opf.write(line)
            counts["outlines"] += 1
            continue
        try:
            parts = line.split(maxsplit=2)
            surtk = parts[0].split(b"?")[0].strip(b"/,")
            freq = int(parts[1])
        except Exception as e:
            print(e)
            continue
        if b"," not in surtk:
            continue
        host, _, path = surtk.partition(b")")
        keys = {
            "host": _gen_keys(host, "host"),
            "path": _gen_keys(surtk, "path")
        }

        for layer in ["host", "path"]:
            for i in range(len(keys[layer])):
                if not trail[layer][i]:
                    _init_node(layer, i)
                elif trail[layer][i]["key"] == keys[layer][i]:
                    trail[layer][i]["mcount"] += freq
                else:
                    _compact_subtree(layer, i)
                    _init_node(layer, i)

        opf.write(surtk + b" %d\n" % freq)
        counts["outlines"] += 1
    _compact_subtree("host", 0)
    _compact_subtree("path", 0)
    opf.truncate()
    counts["outbytes"] += opf.tell()
    opf.close()
    return counts


def cdx2hxpx(infiter):
    key = None
    count = 0
    for line in infiter:
        try:
            surtk = line.split(maxsplit=1)[0].split(b"?")[0].strip(b"/,")
        except Exception as e:
            continue
        if b")" not in surtk:
            surtk = None
        if key == surtk:
            count += 1
        if key != surtk:
            if key:
                yield key + b" %d" % count
            key = surtk
            count = 1
    if key:
        yield key + b" %d" % count


if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit(f"{sys.argv[0]} <outfile> <weight> [- | <files>...]")

    inp = cdx2hxpx(fileinput.input(sys.argv[3:], mode="rb"))
    compact(inp, sys.argv[1], hcf=float(sys.argv[2]), pcf=float(sys.argv[2]))
