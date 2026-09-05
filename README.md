# Hive website — live Supabase auth

The marketing site at [samkomedved319-dev.github.io/hive](https://samkomedved319-dev.github.io/hive) uses **Supabase email + password** login.

- Project: **HiveWEB** (`nqkmnmwbmikbgopwkvse`, eu-west-1)
- URL: `https://nqkmnmwbmikbgopwkvse.supabase.co`
- Provider: Email (sign-up open, auto-confirm on)
- New accounts land as **pending** in `public.profiles`
- Each account gets a sequential **customer number** (`#1`, `#2`, …)

## What is wired

| Piece | Status |
| --- | --- |
| Email / password Auth | On |
| Auto-confirm email | On |
| `public.profiles` + RLS | On |
| Trigger `on_auth_user_created` | Creates a pending profile on signup |
| Site URL / redirect allowlist | GitHub Pages + localhost |
| Site keys in `index.html` | Project URL + anon (public) key |

The anon key in `index.html` is the public browser key. Do **not** put the `service_role` key in the site.

## Approve members

Supabase dashboard → Table Editor → `profiles` → set `status` to `approved` or `denied`.

Members can rename themselves, toggle email updates, and sign out from the avatar chip.

## Recreate the schema

If you spin up a new project, run [`supabase/schema.sql`](supabase/schema.sql) in the SQL editor, then paste the new project URL + anon key into `index.html`.
