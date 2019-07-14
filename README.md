# Mixeddoubles

Purpose: Build mixed doubles randomly paired rosters for as many as four courts from lists of registered players.
The elixir version is functionally incomplete but identical to the javascript version, as far as it goes.

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
