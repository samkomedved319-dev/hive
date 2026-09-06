# Spaceship upload — hivetools.pro/hive

Upload these into the **same folder** that already has `index.html` and `logohive.png`
(usually `public_html/hive/`). Do **not** nest another `hive/` folder.

## Required (download page fix)

| File on GitHub | Upload as |
|---|---|
| `download.html` | `download.html` |
| `index.html` | `index.html` (overwrite) |
| `docs.html` | `docs.html` (overwrite) |
| `download-win.html` | `download-win.html` |
| `drop.html` | `drop.html` |
| `spaceship/htaccess.txt` | `.htaccess` (rename — leading dot) |
| `logohive.png` | keep existing if already there |

Optional: also upload the `download/` folder (`download/index.html`) so `/hive/download/` works without rewrite.

## After upload

Open:

- https://hivetools.pro/hive/download.html
- https://hivetools.pro/hive/download/

Both should show a **working** Download button. The button starts on 0.0.1.5 (the live installer) and switches to 0.0.1.6 the moment that GitHub release exists.
