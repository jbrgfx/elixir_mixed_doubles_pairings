# Mixeddoubles

Purpose: Build mixed doubles randomly paired rosters for as many as four courts from lists of registered players.  Players who registered last and are left unpaired are assigned to wait-lists.

## running using iex
    Clone the repo and in the project directory:

    λ mix deps.get
    λ iex -S mix mixed_doubles
    λ iex --werl -S mix mixed_doubles (on windows to get tab-completion in the erlang terminal)

    Assign teams to courts and print waitlists:

    iex(1) MixedDoubles.assignCourts
    +-----------------+
    |   Assignments   |
    +-------+---------+
    | Court | Team    |
    +-------+---------+
    | 1     | Jane    |
    |       | Robert  |
    | 1     | Dorothy |
    |       | John    |
    | 2     | Lynda   |
    |       | Kevin   |
    | 2     | Carol   |
    |       | Jim     |
    | 3     | Barb    |
    |       | Ben     |
    | 3     | Alice   |
    |       | Brian   |
    | 4     | Beth    |
    |       | Rocky   |
    | 4     | Kelly   |
    |       | Dave    |
    +-------+---------+

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
