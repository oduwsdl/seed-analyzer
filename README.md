# Seed Analyzer

Scripts to analyze collection seeds for their diversity and entropy.
COVID-19 seeds from Micro Collections and IIPC are included as an example.

To perform collection seed analysis first ensure that the needed Python packages are installed:

```
$ pip install tldextract surt
```

Then run the analyzer script with optional arguments as shown below:

```
$ ./seed-analyzer.sh [[[<COLLECTION>] <SEEDDIR>] <OUTDIR>]
```

The script expects seed files named as `<COLLECTION>-<SOURCE>.txt` and placed in `<OUTDIR>`.

During the analysis logs will be printed on the `STDERR` and summary will be printed on the `STDOUT` in TSV format.

Following is a sample run on the supplied default dataset (see the result summary in [COVID19-results.tsv](COVID19-results.tsv)):

```
$ ./seed-analyzer.sh > COVID19-results.tsv
[2020/03/05 04:02:56.515446531] Creating output directory (if missing): derivatives
[2020/03/05 04:02:56.522586508] Removing any COVID19 files from the output directory: derivatives/COVID19*
[2020/03/05 04:02:56.543699088] Copying seed file: seeds/COVID19-IIPC.txt -> derivatives/COVID19-IIPC.SEED
[2020/03/05 04:02:56.556496611] Copying seed file: seeds/COVID19-MC.txt -> derivatives/COVID19-MC.SEED
[2020/03/05 04:02:56.562211899] Merging all seed files: derivatives/COVID19-MERGED.SEED
[2020/03/05 04:02:56.567781490] Generating: derivatives/COVID19-IIPC.URIR
[2020/03/05 04:02:56.578039778] Generating: derivatives/COVID19-IIPC.SURT
[2020/03/05 04:02:57.053687481] Generating: derivatives/COVID19-IIPC.HxPx
[2020/03/05 04:02:57.554363438] Generating: derivatives/COVID19-IIPC.HxP1
[2020/03/05 04:02:58.053235443] Generating: derivatives/COVID19-IIPC.H3P0
[2020/03/05 04:02:58.561272261] Generating: derivatives/COVID19-IIPC.H1P0
[2020/03/05 04:02:59.046740816] Generating: derivatives/COVID19-IIPC.DSuf
[2020/03/05 04:02:59.537874478] Generating: derivatives/COVID19-IIPC.DDom
[2020/03/05 04:03:00.032127705] Generating: derivatives/COVID19-IIPC.DSub
[2020/03/05 04:03:00.540151417] Generating: derivatives/COVID19-IIPC.DPth
[2020/03/05 04:03:01.106741006] Generating: derivatives/COVID19-IIPC.DQry
[2020/03/05 04:03:01.729950334] Generating: derivatives/COVID19-IIPC.DIni
[2020/03/05 04:03:02.289863021] Generating: derivatives/COVID19-IIPC.W1.00
[2020/03/05 04:03:02.453761520] Generating: derivatives/COVID19-IIPC.W0.50
[2020/03/05 04:03:02.612707480] Generating: derivatives/COVID19-IIPC.W0.10
[2020/03/05 04:03:02.776813684] Generating: derivatives/COVID19-IIPC.W0.05
[2020/03/05 04:03:02.946787853] Generating: derivatives/COVID19-IIPC.W0.01
[2020/03/05 04:03:03.110765606] Generating: derivatives/COVID19-MC.URIR
[2020/03/05 04:03:03.112608929] Generating: derivatives/COVID19-MC.SURT
[2020/03/05 04:03:03.362475297] Generating: derivatives/COVID19-MC.HxPx
[2020/03/05 04:03:03.604612484] Generating: derivatives/COVID19-MC.HxP1
[2020/03/05 04:03:03.848976470] Generating: derivatives/COVID19-MC.H3P0
[2020/03/05 04:03:04.085425880] Generating: derivatives/COVID19-MC.H1P0
[2020/03/05 04:03:04.338921785] Generating: derivatives/COVID19-MC.DSuf
[2020/03/05 04:03:04.578854463] Generating: derivatives/COVID19-MC.DDom
[2020/03/05 04:03:04.816419088] Generating: derivatives/COVID19-MC.DSub
[2020/03/05 04:03:05.061350836] Generating: derivatives/COVID19-MC.DPth
[2020/03/05 04:03:05.314104397] Generating: derivatives/COVID19-MC.DQry
[2020/03/05 04:03:05.566980215] Generating: derivatives/COVID19-MC.DIni
[2020/03/05 04:03:05.814575338] Generating: derivatives/COVID19-MC.W1.00
[2020/03/05 04:03:05.856997537] Generating: derivatives/COVID19-MC.W0.50
[2020/03/05 04:03:05.900478669] Generating: derivatives/COVID19-MC.W0.10
[2020/03/05 04:03:05.942494229] Generating: derivatives/COVID19-MC.W0.05
[2020/03/05 04:03:05.983867185] Generating: derivatives/COVID19-MC.W0.01
[2020/03/05 04:03:06.030947357] Generating: derivatives/COVID19-MERGED.URIR
[2020/03/05 04:03:06.034962205] Generating: derivatives/COVID19-MERGED.SURT
[2020/03/05 04:03:06.529346355] Generating: derivatives/COVID19-MERGED.HxPx
[2020/03/05 04:03:07.049847229] Generating: derivatives/COVID19-MERGED.HxP1
[2020/03/05 04:03:07.579511252] Generating: derivatives/COVID19-MERGED.H3P0
[2020/03/05 04:03:08.093925224] Generating: derivatives/COVID19-MERGED.H1P0
[2020/03/05 04:03:08.628848084] Generating: derivatives/COVID19-MERGED.DSuf
[2020/03/05 04:03:09.124614405] Generating: derivatives/COVID19-MERGED.DDom
[2020/03/05 04:03:09.637375394] Generating: derivatives/COVID19-MERGED.DSub
[2020/03/05 04:03:10.160752675] Generating: derivatives/COVID19-MERGED.DPth
[2020/03/05 04:03:10.776821303] Generating: derivatives/COVID19-MERGED.DQry
[2020/03/05 04:03:11.370664911] Generating: derivatives/COVID19-MERGED.DIni
[2020/03/05 04:03:11.956497275] Generating: derivatives/COVID19-MERGED.W1.00
[2020/03/05 04:03:12.124645260] Generating: derivatives/COVID19-MERGED.W0.50
[2020/03/05 04:03:12.311109998] Generating: derivatives/COVID19-MERGED.W0.10
[2020/03/05 04:03:12.496881028] Generating: derivatives/COVID19-MERGED.W0.05
[2020/03/05 04:03:12.674768136] Generating: derivatives/COVID19-MERGED.W0.01
[2020/03/05 04:03:12.854050603] Analyzing derived files to report summary
[2020/03/05 04:03:13.272577315] All done!
```
