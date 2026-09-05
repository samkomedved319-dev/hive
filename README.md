# Hive website — live Supabase waitlist

Live site: https://samkomedved319-dev.github.io/hive

Creating an account puts you on the **waitlist**. The page shows how many people are waiting — not a private login number.

## Where to view members

Open the Supabase project **HiveWEB**:

1. [Authentication → Users](https://supabase.com/dashboard/project/nqkmnmwbmikbgopwkvse/auth/users) — every account
2. [Table Editor → profiles](https://supabase.com/dashboard/project/nqkmnmwbmikbgopwkvse/editor) — waitlist rows (`status` = pending / approved / denied)

Flip `status` to `approved` to let someone off the waitlist.

## Public count

`waitlist_stats()` returns `{ total, waiting }` for the site. Anon clients can call it; emails stay private.
