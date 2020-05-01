# Seed Analyzer

Scripts to analyze collection seeds for their diversity and entropy.
COVID-19 seeds from Micro Collections and IIPC are included as an example.

To perform collection seed analysis first ensure that the needed Python packages are installed:

```
$ pip install tldextract surt
```

Then run the analyzer script with optional arguments as shown below:

```
$ ./seed-analyzer.sh [[[<COLLECTION>] <SEEDDIR>] <OPDIR>]
```

During the analysis INFO logs will be printed on the `STDERR` and summary will be printed on the `STDOUT` in TSV format.

Following is a sample run on the supplied default dataset (see the result summary in [covid19-results.tsv](covid19-results.tsv)):

```
$ ./seed-analyzer.sh > covid19-results.tsv
[INFO 2020/01/05 16:16:39.516906561] Creating output directory (if missing): derivatives
[INFO 2020/01/05 16:16:39.524008376] Removing any COVID19 files from the output directory: derivatives/COVID19*
[INFO 2020/01/05 16:16:39.529717942] Working on the seed file: seeds/COVID19-MC.txt
[INFO 2020/01/05 16:16:39.532668857] Generating: derivatives/MC.SEED
[INFO 2020/01/05 16:16:39.541187977] Generating: derivatives/MC.URIR
[INFO 2020/01/05 16:16:39.548473605] Generating: derivatives/MC.SURT
[INFO 2020/01/05 16:16:39.803861539] Generating: derivatives/MC.HxPx
[INFO 2020/01/05 16:16:40.042699974] Generating: derivatives/MC.HxP1
[INFO 2020/01/05 16:16:40.286714974] Generating: derivatives/MC.H3P0
[INFO 2020/01/05 16:16:40.527016419] Generating: derivatives/MC.H1P0
[INFO 2020/01/05 16:16:40.764062690] Generating: derivatives/MC.DDom
[INFO 2020/01/05 16:16:41.006777539] Generating: derivatives/MC.DSub
[INFO 2020/01/05 16:16:41.253191060] Generating: derivatives/MC.DPth
[INFO 2020/01/05 16:16:41.510320078] Generating: derivatives/MC.DQry
[INFO 2020/01/05 16:16:41.751722422] Generating: derivatives/MC.DIni
[INFO 2020/01/05 16:16:41.996769297] Generating: derivatives/MC.W1.00
[INFO 2020/01/05 16:16:42.039469315] Generating: derivatives/MC.W0.50
[INFO 2020/01/05 16:16:42.082729299] Generating: derivatives/MC.W0.10
[INFO 2020/01/05 16:16:42.125468785] Generating: derivatives/MC.W0.05
[INFO 2020/01/05 16:16:42.169841378] Generating: derivatives/MC.W0.01
[INFO 2020/01/05 16:16:42.213753906] Working on the seed file: seeds/COVID19-IIPC.txt
[INFO 2020/01/05 16:16:42.214545332] Generating: derivatives/IIPC.SEED
[INFO 2020/01/05 16:16:42.216703550] Generating: derivatives/IIPC.URIR
[INFO 2020/01/05 16:16:42.220360683] Generating: derivatives/IIPC.SURT
[INFO 2020/01/05 16:16:42.684722015] Generating: derivatives/IIPC.HxPx
[INFO 2020/01/05 16:16:43.172521492] Generating: derivatives/IIPC.HxP1
[INFO 2020/01/05 16:16:43.679644508] Generating: derivatives/IIPC.H3P0
[INFO 2020/01/05 16:16:44.168507199] Generating: derivatives/IIPC.H1P0
[INFO 2020/01/05 16:16:44.654158395] Generating: derivatives/IIPC.DDom
[INFO 2020/01/05 16:16:45.186374826] Generating: derivatives/IIPC.DSub
[INFO 2020/01/05 16:16:45.720202793] Generating: derivatives/IIPC.DPth
[INFO 2020/01/05 16:16:46.266536921] Generating: derivatives/IIPC.DQry
[INFO 2020/01/05 16:16:46.822604012] Generating: derivatives/IIPC.DIni
[INFO 2020/01/05 16:16:47.387358110] Generating: derivatives/IIPC.W1.00
[INFO 2020/01/05 16:16:47.547764541] Generating: derivatives/IIPC.W0.50
[INFO 2020/01/05 16:16:47.705427046] Generating: derivatives/IIPC.W0.10
[INFO 2020/01/05 16:16:47.869246177] Generating: derivatives/IIPC.W0.05
[INFO 2020/01/05 16:16:48.032216691] Generating: derivatives/IIPC.W0.01
[INFO 2020/01/05 16:16:48.200488006] Working on the seed file: seeds/COVID19-Merged.txt
[INFO 2020/01/05 16:16:48.201379541] Generating: derivatives/Merged.SEED
[INFO 2020/01/05 16:16:48.203634678] Generating: derivatives/Merged.URIR
[INFO 2020/01/05 16:16:48.207408603] Generating: derivatives/Merged.SURT
[INFO 2020/01/05 16:16:48.710420617] Generating: derivatives/Merged.HxPx
[INFO 2020/01/05 16:16:49.228832509] Generating: derivatives/Merged.HxP1
[INFO 2020/01/05 16:16:49.746158541] Generating: derivatives/Merged.H3P0
[INFO 2020/01/05 16:16:50.262030376] Generating: derivatives/Merged.H1P0
[INFO 2020/01/05 16:16:50.789695018] Generating: derivatives/Merged.DDom
[INFO 2020/01/05 16:16:51.356660840] Generating: derivatives/Merged.DSub
[INFO 2020/01/05 16:16:51.924729007] Generating: derivatives/Merged.DPth
[INFO 2020/01/05 16:16:52.511895519] Generating: derivatives/Merged.DQry
[INFO 2020/01/05 16:16:53.085960683] Generating: derivatives/Merged.DIni
[INFO 2020/01/05 16:16:53.672334736] Generating: derivatives/Merged.W1.00
[INFO 2020/01/05 16:16:53.841890599] Generating: derivatives/Merged.W0.50
[INFO 2020/01/05 16:16:54.006421022] Generating: derivatives/Merged.W0.10
[INFO 2020/01/05 16:16:54.182402959] Generating: derivatives/Merged.W0.05
[INFO 2020/01/05 16:16:54.358845127] Generating: derivatives/Merged.W0.01
[INFO 2020/01/05 16:16:54.536524814] Analyzing generated files to report summary
[INFO 2020/01/05 16:16:54.971865802] All done!
```
