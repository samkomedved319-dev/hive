# Hive installer drops

This folder is the public download (no GitHub login). The marketing site does not link here.

## Ship a new version

1. Name the installer `HiveSetup-X.Y.Z.exe` (example: `HiveSetup-0.0.4.exe`).
2. Put it in this folder (`builds/`).
3. Edit `version.json` — change `version`, `filename`, `pageFile`, `githubRelease`, `notes`, `released`.
4. Optional: also attach the same file to a GitHub Release (`vX.Y.Z`).
5. Commit and push `main`. The drop page picks up `version.json` automatically.

Keep `drop.html` unchanged unless you are restyling it.

GitHub Pages file limit is 100 MB per file.
