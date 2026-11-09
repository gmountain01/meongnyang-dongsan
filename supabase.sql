-- 멍냥이 동산: Supabase 설정용 SQL
-- Supabase 대시보드 > SQL Editor에 붙여 넣고 Run 하세요.

-- 1) 돌보미별 저장 데이터 (익명 로그인 사용자 1명당 1줄)
create table if not exists public.saves (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

-- 2) 자기 데이터만 읽고 쓸 수 있게 (RLS)
alter table public.saves enable row level security;

drop policy if exists "saves_select_own" on public.saves;
drop policy if exists "saves_insert_own" on public.saves;
drop policy if exists "saves_update_own" on public.saves;

create policy "saves_select_own" on public.saves
  for select using (auth.uid() = user_id);
create policy "saves_insert_own" on public.saves
  for insert with check (auth.uid() = user_id);
create policy "saves_update_own" on public.saves
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- 마을 동산(실시간)은 Realtime의 Broadcast·Presence 채널만 써서 따로 만들 테이블이 없어요.

-- 3) 마을 동산 신고 (쓰기만 가능, 읽기는 대시보드에서 관리자만)
create table if not exists public.reports (
  id          bigserial primary key,
  reporter    uuid not null default auth.uid() references auth.users(id) on delete set null,
  target_pid  text not null,
  target_name text,
  reason      text not null,
  room        text,
  created_at  timestamptz not null default now()
);
alter table public.reports enable row level security;
drop policy if exists "reports_insert_own" on public.reports;
create policy "reports_insert_own" on public.reports
  for insert with check (auth.uid() = reporter);
-- 신고 목록은 Supabase 대시보드 > Table Editor > reports 에서 확인하세요.
