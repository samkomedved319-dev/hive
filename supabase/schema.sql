-- Hive website auth schema (already applied on project nqkmnmwbmikbgopwkvse)
create table if not exists public.profiles (
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

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, display_name, status)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1), 'Hive member'),
    'pending'
  )
  on conflict (id) do update
    set email = excluded.email;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

create or replace function public.waitlist_stats()
returns json
language sql
security definer
set search_path = public
stable
as $$
  select json_build_object(
    'total', (select count(*) from public.profiles),
    'waiting', (select count(*) from public.profiles where status = 'pending')
  );
$$;

grant execute on function public.waitlist_stats() to anon, authenticated;

create table if not exists public.feedback (
  id uuid primary key default gen_random_uuid(),
  email text,
  body text not null,
  rating int,
  status text not null default 'pending'
    check (status in ('pending', 'reviewed', 'shipped')),
  created_at timestamptz not null default now()
);
alter table public.feedback enable row level security;
drop policy if exists "insert feedback" on public.feedback;
create policy "insert feedback" on public.feedback for insert with check (true);
drop policy if exists "read own feedback" on public.feedback;
create policy "read own feedback" on public.feedback for select using (true);


