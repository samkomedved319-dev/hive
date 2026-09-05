# Hive website — live waitlist

Live site: https://samkomedved319-dev.github.io/hive

Creating an account puts you on the **waitlist**. The page shows how many people are waiting — not a private login number.

Hive is an invite-only Windows preview. The public site does not ship an installer.

## Where to view members

Open the Supabase project **HiveWEB**:

1. Authentication → Users — every account
2. Table Editor → profiles — waitlist rows (`status` = pending / approved / denied)

Flip `status` to `approved` to let someone off the waitlist.

## Public count

`waitlist_stats()` returns `{ total, waiting }` for the site. Anon clients can call it; emails stay private.
