# Hive website — Supabase auth setup (5 minutes)

The nav has real email sign-in powered by Supabase. New accounts land as
**pending** — you approve or deny them in the Supabase dashboard — and every
account gets a sequential **customer number** (#1, #2, …) shown in its profile.

## 1. Create the project

1. Go to <https://supabase.com/dashboard> → New project (free tier is fine)
2. Note the **Project URL** and **anon public key** (Settings → API)

## 2. Create the profiles table

SQL Editor → New query → paste, run:

```sql
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  display_name text,
  status text not null default 'pending'
    check (status in ('pending', 'approved', 'denied')),
  customer_number serial unique,
  notify boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "read own profile"
  on public.profiles for select using (auth.uid() = id);

create policy "create own profile"
  on public.profiles for insert with check (auth.uid() = id);

create policy "update own profile"
  on public.profiles for update using (auth.uid() = id);
```

`customer_number` is a sequence: the first signup gets #1, the next #2 — that
is the "sign-in number" shown in each profile. Statuses start at `pending`.

## 3. Email sign-in settings (recommended)

Authentication → Providers → Email: turn **Confirm email OFF** so new
accounts can sign straight in (keep it ON if you prefer verified emails —
the site shows a "check your inbox" message in that case).

## 4. Wire the site

In `index.html`, replace:

```js
var SUPABASE_URL = 'PASTE-YOUR-SUPABASE-URL';
var SUPABASE_ANON_KEY = 'PASTE-YOUR-SUPABASE-ANON-KEY';
```

with your values. Commit + push — login lights up automatically. Until then,
the Sign in button explains the setup instead of failing.

## 5. Approving members

Table Editor → `profiles` → flip `status` to `approved` (or `denied`).
Members see their badge, number, join date, can rename themselves, toggle
email updates, and sign out — all in the profile panel behind their avatar.
