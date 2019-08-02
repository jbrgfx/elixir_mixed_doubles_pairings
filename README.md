# Mixeddoubles

Purpose: Build mixed doubles randomly paired rosters for as many as four courts from lists of registered players.  Players who registered last and are left unpaired are assigned to wait-lists.

The elixir version is functionally superior to the javascript version.

## running using iex
    Clone the repo and in the project directory:
    
    λ mix deps.get
    λ iex -S mix
    λ iex --werl -S mix (on windows to get tab-completion in the erlang terminal)
    
    Assign teams to courts and print waitlists:
    
    iex(1) MixedDoubles.assignCourts
    +----------------------+
    |       Court 1        |
    +------+--------+------+
    |      | Ladies | Men  |
    +------+--------+------+
    | Team | Alice  | Jim  |
    | Team | Carol  | John |
    +------+--------+------+

    +------------------------+
    |        Court 2         |
    +------+---------+-------+
    |      | Ladies  | Men   |
    +------+---------+-------+
    | Team | Dorothy | Kevin |
    | Team | Beth    | Jim   |
    +------+---------+-------+

    +-----------------------+
    |        Court 3        |
    +------+--------+-------+
    |      | Ladies | Men   |
    +------+--------+-------+
    | Team | Alice  | Jim   |
    | Team | Kelly  | Rocky |
    +------+--------+-------+

    +-----------------------+
    |        Court 4        |
    +------+--------+-------+
    |      | Ladies | Men   |
    +------+--------+-------+
    | Team | Jane   | Dave  |
    | Team | Lynda  | Kevin |
    +------+--------+-------+

    +----------------+
    | Ladies Waiting |
    +----------------+
    | Molly          |
    | Polly          |
    | Joan           |
    +----------------+

    +-------------+
    | Men Waiting |
    +-------------+
    | Jon         |
    | Kelly       |
    | Peter       |
    | Chris       |
    +-------------+


#### assign Teams 

    iex(2) MixedDoubles.assignTeams

#### construct waitlists

    iex(3)> MixedDoubles.femalesWaitlist
    iex(4)> MixedDoubles.malesWaitlist
