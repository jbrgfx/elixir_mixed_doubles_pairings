# Mixeddoubles

Purpose: Build mixed doubles randomly paired rosters for as many as four courts from lists of registered players.  Players who registered last and are left unpaired are assigned to wait-lists.

The elixir version is functionally identical to the javascript version.

## running using iex

    λ iex mixeddoubles.exs
    λ iex --werl mixeddoubles.exs (on windows to get tab-completion in the erlang terminal)

    iex(1) players = MixedDoubles.assignTeams

#### construct waitlists

    iex(3)> MixedDoubles.femalesWaitlist
    iex(4)> MixedDoubles.malesWaitlist


### TODO:

  ##### Add a function to increment team number and index for assigning teams
  ##### Add a function to format printing to the terminal
  Both of these are currently done verbosely.
