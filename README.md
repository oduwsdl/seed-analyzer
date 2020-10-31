# Seed Analyzer

Scripts to analyze collection seeds for their diversity and entropy.
COVID-19 seeds from Micro Collections and IIPC are included as an example.

To perform collection seed analysis first ensure that the needed Python packages are installed:

```
$ pip install -r requirements.txt
```

Then run the analyzer script with optional arguments as shown below:

```
$ ./seed-analyzer.sh [[[<COLLECTION>] <SEEDDIR>] <OUTDIR>]
```

The script expects seed files named as `<COLLECTION>-<SOURCE>.txt` and placed in `<OUTDIR>`.

During the analysis logs will be printed on the `STDERR` and summary will be printed on the `STDOUT` in TSV format.

Following is a sample run on the supplied default dataset (see the result summary in [COVID19-results.tsv](COVID19-results.tsv)):

<details>
  <summary>$ ./seed-analyzer.sh > COVID19-results.tsv</summary>

```
[2020/10/31 15:22:07.959675717] Creating output directory (if missing): derivatives
[2020/10/31 15:22:07.970054387] Removing any COVID19 files from the output directory: derivatives/COVID19*
[2020/10/31 15:22:07.991806346] Copying seed file: seeds/COVID19-IIPC.txt -> derivatives/COVID19-IIPC.SEED
[2020/10/31 15:22:08.010233847] Copying seed file: seeds/COVID19-MC.txt -> derivatives/COVID19-MC.SEED
[2020/10/31 15:22:08.018983710] Merging all seed files: derivatives/COVID19-MERGED.SEED
[2020/10/31 15:22:08.028593117] Generating: derivatives/COVID19-IIPC.URIR
[2020/10/31 15:22:08.046801953] Generating: derivatives/COVID19-IIPC.SURT
[2020/10/31 15:22:08.534329317] Generating: derivatives/COVID19-IIPC.HxPx
[2020/10/31 15:22:09.014422102] Generating: derivatives/COVID19-IIPC.HxP1
[2020/10/31 15:22:09.507995649] Generating: derivatives/COVID19-IIPC.HxP0
[2020/10/31 15:22:09.986034051] Generating: derivatives/COVID19-IIPC.H3P0
[2020/10/31 15:22:10.469348498] Generating: derivatives/COVID19-IIPC.H2P0
[2020/10/31 15:22:10.956227499] Generating: derivatives/COVID19-IIPC.H1P0
[2020/10/31 15:22:11.457875560] Generating: derivatives/COVID19-IIPC.DSuf
[2020/10/31 15:22:12.041002753] Generating: derivatives/COVID19-IIPC.DDom
[2020/10/31 15:22:12.517638675] Generating: derivatives/COVID19-IIPC.DSub
[2020/10/31 15:22:12.968364575] Generating: derivatives/COVID19-IIPC.DPth
[2020/10/31 15:22:13.508816859] Generating: derivatives/COVID19-IIPC.DQry
[2020/10/31 15:22:14.028286841] Generating: derivatives/COVID19-IIPC.DIni
[2020/10/31 15:22:14.560887105] Generating: derivatives/COVID19-IIPC.W2.00
[2020/10/31 15:22:14.718862161] Generating: derivatives/COVID19-IIPC.W1.00
[2020/10/31 15:22:14.870307954] Generating: derivatives/COVID19-IIPC.W0.50
[2020/10/31 15:22:15.024846597] Generating: derivatives/COVID19-IIPC.W0.10
[2020/10/31 15:22:15.192371500] Generating: derivatives/COVID19-IIPC.W0.05
[2020/10/31 15:22:15.359863946] Generating: derivatives/COVID19-IIPC.W0.01
[2020/10/31 15:22:15.526946405] Generating: derivatives/COVID19-MC.URIR
[2020/10/31 15:22:15.528869499] Generating: derivatives/COVID19-MC.SURT
[2020/10/31 15:22:15.717008116] Generating: derivatives/COVID19-MC.HxPx
[2020/10/31 15:22:15.914860994] Generating: derivatives/COVID19-MC.HxP1
[2020/10/31 15:22:16.109401830] Generating: derivatives/COVID19-MC.HxP0
[2020/10/31 15:22:16.317458150] Generating: derivatives/COVID19-MC.H3P0
[2020/10/31 15:22:16.516980237] Generating: derivatives/COVID19-MC.H2P0
[2020/10/31 15:22:16.704772470] Generating: derivatives/COVID19-MC.H1P0
[2020/10/31 15:22:16.897298147] Generating: derivatives/COVID19-MC.DSuf
[2020/10/31 15:22:17.102698065] Generating: derivatives/COVID19-MC.DDom
[2020/10/31 15:22:17.331513844] Generating: derivatives/COVID19-MC.DSub
[2020/10/31 15:22:17.541679267] Generating: derivatives/COVID19-MC.DPth
[2020/10/31 15:22:17.759519983] Generating: derivatives/COVID19-MC.DQry
[2020/10/31 15:22:17.976024525] Generating: derivatives/COVID19-MC.DIni
[2020/10/31 15:22:18.196935852] Generating: derivatives/COVID19-MC.W2.00
[2020/10/31 15:22:18.242803622] Generating: derivatives/COVID19-MC.W1.00
[2020/10/31 15:22:18.289302974] Generating: derivatives/COVID19-MC.W0.50
[2020/10/31 15:22:18.336262113] Generating: derivatives/COVID19-MC.W0.10
[2020/10/31 15:22:18.383202504] Generating: derivatives/COVID19-MC.W0.05
[2020/10/31 15:22:18.428925142] Generating: derivatives/COVID19-MC.W0.01
[2020/10/31 15:22:18.475049839] Generating: derivatives/COVID19-MERGED.URIR
[2020/10/31 15:22:18.479304133] Generating: derivatives/COVID19-MERGED.SURT
[2020/10/31 15:22:18.933163157] Generating: derivatives/COVID19-MERGED.HxPx
[2020/10/31 15:22:19.433151902] Generating: derivatives/COVID19-MERGED.HxP1
[2020/10/31 15:22:19.916026707] Generating: derivatives/COVID19-MERGED.HxP0
[2020/10/31 15:22:20.421172306] Generating: derivatives/COVID19-MERGED.H3P0
[2020/10/31 15:22:20.915556807] Generating: derivatives/COVID19-MERGED.H2P0
[2020/10/31 15:22:21.440732493] Generating: derivatives/COVID19-MERGED.H1P0
[2020/10/31 15:22:21.891751356] Generating: derivatives/COVID19-MERGED.DSuf
[2020/10/31 15:22:22.365648184] Generating: derivatives/COVID19-MERGED.DDom
[2020/10/31 15:22:22.838301136] Generating: derivatives/COVID19-MERGED.DSub
[2020/10/31 15:22:23.327639814] Generating: derivatives/COVID19-MERGED.DPth
[2020/10/31 15:22:23.867492793] Generating: derivatives/COVID19-MERGED.DQry
[2020/10/31 15:22:24.427140223] Generating: derivatives/COVID19-MERGED.DIni
[2020/10/31 15:22:24.977369282] Generating: derivatives/COVID19-MERGED.W2.00
[2020/10/31 15:22:25.146951351] Generating: derivatives/COVID19-MERGED.W1.00
[2020/10/31 15:22:25.329597739] Generating: derivatives/COVID19-MERGED.W0.50
[2020/10/31 15:22:25.501047410] Generating: derivatives/COVID19-MERGED.W0.10
[2020/10/31 15:22:25.677773355] Generating: derivatives/COVID19-MERGED.W0.05
[2020/10/31 15:22:25.854172209] Generating: derivatives/COVID19-MERGED.W0.01
[2020/10/31 15:22:26.034237135] Analyzing derived files to report summary
[2020/10/31 15:22:26.512877291] All done!
```
</details>
