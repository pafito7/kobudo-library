drop policy if exists "Authors can update their videos" on public.videos;
drop policy if exists "Members can update videos" on public.videos;

create policy "Members can update videos"
  on public.videos for update to authenticated
  using (true)
  with check (true);

grant update on public.videos to authenticated;
