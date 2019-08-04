defmodule MixedDoubles do
  @moduledoc """
  Creates random court assignments for mixed doubles pairings
  with wait-lists for as many as four courts.

  Create a roster using the main command:
  iex(1) MixedDoubles.assignCourts
  """
  def females do
    [
      "Alice",
      "Lynda",
      "Carol",
      "Kelly",
      "Dorothy",
      "Beth",
      "Jane",
      "Barb",
      "Molly",
      "Polly",
      "Joan"
    ]
  end

  def males do
    [
      "John",
      "Kevin",
      "Dave",
      "Rocky",
      "Robert",
      "Ben",
      "Jim",
      "Brian",
      "Jon",
      "Kelly",
      "Peter",
      "Chris"
    ]
  end

  @doc """
  Counts female Players
  """
  def countFemales do
    Enum.count(females())
  end

  @doc """
  Counts male Players
  """
  def countMales do
    Enum.count(males())
  end

  @doc """
  limits the shuffle of female and males players
  and to set the index for setting up waitlists
  this ensures that pairings for each team will be mixed
  -- each pair must have one female and one male
  """
  def lesserCount do
    cond do
      countMales() > countFemales() -> countFemales()
      countMales() < countFemales() -> countMales()
      countMales() == countFemales() -> countFemales()
    end
  end

  @doc """
  Determines the number of teams for each round of Mixed Doubles
  Enum.max returns the starting index as a constant used in
  waitlists and to set the number of players to shuffle
  """
  def numberOfTeams do
    cond do
      lesserCount() >= 4 ->
        divisible_by_4? = fn n -> rem(n, 4) == 0 end
        teams = for n <- 4..lesserCount(), divisible_by_4?.(n), do: n
        _maxTeams = Enum.max(teams)

      lesserCount() == 3 ->
        _maxTeams = 2

      lesserCount() <= 1 ->
        IO.puts("Insufficient players for mixed doubles")
    end
  end

  @doc """
  Rearranges female players randomly, excluding waitlists.
  """
  def shuffleFemales do
    females() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  @doc """
  Rearranges male players randomly, excluding waitlists.
  """
  def shuffleMales do
    males() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  @doc """
  Constructs teams of female and male players, excluding waitlists.
  """
  def assignTeams do
    players = shuffleFemales() |> Enum.zip(shuffleMales())
    pl = PhStTransform.transform(players, %{Tuple => fn tuple -> Tuple.to_list(tuple) end})
    for n <- pl, do: ["Team"] ++ n
  end

  @doc """
  identifies unpaired, female players
  """
  def femalesWaiting do
    cntFemale = Enum.count(females())
    fw = Enum.slice(females(), numberOfTeams(), cntFemale)
    for n <- fw, do: [n]
  end

  @doc """
  adds unpaired, female players to a waitlist
  """
  def femaleWaitlist do
    cond do
      Enum.count(femalesWaiting()) >= 1 ->
        header = ["Ladies Waiting"]
        rows = femalesWaiting()

        TableRex.quick_render!(rows, header)
        |> IO.puts()

      Enum.count(femalesWaiting()) == 0 ->
        IO.puts("No Ladies waiting")
    end
  end

  @doc """
  identifies unpaired, male players
  """
  def malesWaiting do
    cntMale = Enum.count(males())
    mw = Enum.slice(males(), numberOfTeams(), cntMale)
    for n <- mw, do: [n]
  end

  @doc """
  adds unpaired, male players to a waitlist
  """
  def maleWaitlist do
    cond do
      Enum.count(malesWaiting()) >= 1 ->
        header = ["Men Waiting"]
        rows = malesWaiting()

        TableRex.quick_render!(rows, header)
        |> IO.puts()

      Enum.count(malesWaiting()) == 0 ->
        IO.puts("No Men waiting")
    end
  end

  @doc """
  Assigns teams to courts and prints rosters as well as waitlists
  """
  def assignCourts do
    cond do
      numberOfTeams() == 8 ->
        title = "Court 1"
        header = ["", "Ladies", "Men"]
        court1 = Enum.slice(assignTeams(), 0..1)

        TableRex.quick_render!(court1, header, title)
        |> IO.puts()

        title = "Court 2"
        header = ["", "Ladies", "Men"]
        court2 = Enum.slice(assignTeams(), 2..3)

        TableRex.quick_render!(court2, header, title)
        |> IO.puts()

        title = "Court 3"
        header = ["", "Ladies", "Men"]
        court3 = Enum.slice(assignTeams(), 4..5)

        TableRex.quick_render!(court3, header, title)
        |> IO.puts()

        title = "Court 4"
        header = ["", "Ladies", "Men"]
        court4 = Enum.slice(assignTeams(), 6..7)

        TableRex.quick_render!(court4, header, title)
        |> IO.puts()

      numberOfTeams() == 6 ->
        title = "Court 1"
        header = ["", "Ladies", "Men"]
        court1 = Enum.slice(assignTeams(), 0..1)

        TableRex.quick_render!(court1, header, title)
        |> IO.puts()

        title = "Court 2"
        header = ["", "Ladies", "Men"]
        court2 = Enum.slice(assignTeams(), 2..3)

        TableRex.quick_render!(court2, header, title)
        |> IO.puts()

        title = "Court 3"
        header = ["", "Ladies", "Men"]
        court3 = Enum.slice(assignTeams(), 4..5)

        TableRex.quick_render!(court3, header, title)
        |> IO.puts()

      numberOfTeams() == 4 ->
        title = "Court 1"
        header = ["", "Ladies", "Men"]
        court1 = Enum.slice(assignTeams(), 0..1)

        TableRex.quick_render!(court1, header, title)
        |> IO.puts()

        title = "Court 2"
        header = ["", "Ladies", "Men"]
        court2 = Enum.slice(assignTeams(), 2..3)

        TableRex.quick_render!(court2, header, title)
        |> IO.puts()

      numberOfTeams() == 2 ->
        title = "Court 1"
        header = ["", "Ladies", "Men"]
        court1 = Enum.slice(assignTeams(), 0..1)

        TableRex.quick_render!(court1, header, title)
        |> IO.puts()
    end

    femaleWaitlist()
    maleWaitlist()
  end
end
