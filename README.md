# Hive website — live waitlist

Live site: https://hivetools.pro/hive/

Creating an account puts you on the **waitlist**. The page shows how many people are waiting — not a private login number.

Hive is an invite-only Windows preview. The public site does not ship an installer.

## Auth (required after the domain move)

In the Supabase project **HiveWEB** → Authentication → URL configuration:

1. **Site URL:** `https://hivetools.pro/hive`
2. **Redirect URLs** (one per line):
   - `https://hivetools.pro/hive`
   - `https://hivetools.pro/hive/`
   - `https://hivetools.pro/hive/index.html`
   - `https://hivetools.pro/hive/admin`
   - `https://hivetools.pro/hive/admin/`
   - `https://samkomedved319-dev.github.io/hive`
   - `https://samkomedved319-dev.github.io/hive/`
   - `hive://auth`

Leave **email** signup enabled. Do not put the service_role key in the site files.

## Where to view members

1. Authentication → Users — every account
2. Table Editor → profiles — waitlist rows (`status` = none / pending / approved / denied)

Flip `status` to `approved` to let someone off the waitlist.

## Public count

`waitlist_stats()` returns `{ total, waiting }` for the site. Anon clients can call it; emails stay private.
