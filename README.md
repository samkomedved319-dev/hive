# Hive website — Google login setup (2 minutes)

The site has a real Google Sign-In button in the nav. It activates once you
paste a Google OAuth **Client ID** into `index.html`.

## Steps

1. Go to <https://console.cloud.google.com/apis/credentials>
2. Create credentials → **OAuth client ID** → type **Web application**
3. Under **Authorized JavaScript origins**, add:
   - `https://samkomedved319-dev.github.io`
   - `http://localhost:8000` (optional, for local preview)
4. Copy the client ID (ends with `.apps.googleusercontent.com`)
5. In `index.html`, replace:
   `PASTE-YOUR-GOOGLE-CLIENT-ID.apps.googleusercontent.com`
   with your client ID
6. Commit + push — login lights up on the live site automatically

No backend needed: Google returns an ID token, the site reads the public
profile (name, email, avatar) and keeps it in `localStorage`. Sign-out clears it.

Until the ID is pasted, the nav shows a "Sign in" button that explains the setup.
