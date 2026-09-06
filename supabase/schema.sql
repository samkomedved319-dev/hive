-- Hive website auth + installer hosting
-- Run this whole file once in Supabase SQL editor.

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  display_name text,
  status text not null default 'approved'
    check (status in ('pending', 'approved', 'denied')),
  customer_number serial unique,
  notify boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.profiles add column if not exists is_admin boolean not null default false;

alter table public.profiles enable row level security;

drop policy if exists "read own profile" on public.profiles;
create policy "read own profile"
  on public.profiles for select using (auth.uid() = id);

drop policy if exists "insert own profile" on public.profiles;
drop policy if exists "create own profile" on public.profiles;
create policy "insert own profile"
  on public.profiles for insert with check (auth.uid() = id);

drop policy if exists "update own profile" on public.profiles;
create policy "update own profile"
  on public.profiles for update using (auth.uid() = id);

update public.profiles
  set is_admin = true
  where email ilike '%samkomedved%';

create or replace function public.is_hive_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((
    select p.is_admin or p.email ilike '%samkomedved%'
    from public.profiles p
    where p.id = auth.uid()
  ), false)
  or exists (
    select 1 from auth.users u
    where u.id = auth.uid()
      and coalesce(u.email, '') ilike '%samkomedved%'
  );
$$;

grant execute on function public.is_hive_admin() to anon, authenticated;

insert into storage.buckets (id, name, public, file_size_limit)
  values ('installers', 'installers', true, 524288000)
  on conflict (id) do update
    set public = true,
        file_size_limit = 524288000;

create table if not exists public.releases (
  id uuid primary key default gen_random_uuid(),
  version text not null,
  title text not null,
  notes text,
  filename text not null,
  file_path text not null,
  file_url text,
  file_size bigint,
  is_latest boolean not null default true,
  created_at timestamptz not null default now()
);
alter table public.releases enable row level security;
drop policy if exists "public read releases" on public.releases;
create policy "public read releases" on public.releases for select using (true);
drop policy if exists "admin write releases" on public.releases;
create policy "admin write releases" on public.releases for all
  using (public.is_hive_admin())
  with check (public.is_hive_admin());

drop policy if exists "public read installers" on storage.objects;
create policy "public read installers"
  on storage.objects for select
  using (bucket_id = 'installers');

drop policy if exists "admin write installers" on storage.objects;
create policy "admin write installers"
  on storage.objects for all
  using (bucket_id = 'installers' and public.is_hive_admin())
  with check (bucket_id = 'installers' and public.is_hive_admin());
