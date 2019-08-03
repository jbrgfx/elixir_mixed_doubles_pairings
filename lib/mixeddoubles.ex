defmodule MixedDoubles do
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

  def countFemales do
    Enum.count(females())
  end

  def countMales do
    Enum.count(males())
  end

  # used to limit the shuffle of female and males players
  # and to set the index for setting up waitlists
  # this ensures that pairings for each team will be mixed
  # -- each pair must have one female and one male
  def lesserCount do
    cond do
      countMales() > countFemales() -> countFemales()
      countMales() < countFemales() -> countMales()
      countMales() == countFemales() -> countFemales()
    end
  end

  # Enum.max returns the starting index as a const in
  # waitlists and to set the number of players
  # to shuffle
  def numberOfTeams do
    divisible_by_2? = fn n -> rem(n, 2) == 0 end
    teams = for n <- 1..lesserCount(), divisible_by_4?.(n), do: n
    _maxTeams = Enum.max(teams)
  end

  def shuffleFemales do
    females() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  def shuffleMales do
    males() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  def assignTeams do
    players = shuffleFemales() |> Enum.zip(shuffleMales())
    pl = PhStTransform.transform(players, %{Tuple => fn tuple -> Tuple.to_list(tuple) end})
    for n <- pl, do: ["Team"] ++ n
  end

  # take remainder and add to waitlist
  def femalesWaiting do
    cntFemale = Enum.count(females())
    fw = Enum.slice(females(), numberOfTeams(), cntFemale)
    for n <- fw, do: [n]
  end

  def femaleWaitlist do
    header = ["Ladies Waiting"]
    rows = femalesWaiting()

    TableRex.quick_render!(rows, header)
    |> IO.puts()
  end

  def malesWaiting do
    cntMale = Enum.count(males())
    mw = Enum.slice(males(), numberOfTeams(), cntMale)
    for n <- mw, do: [n]
  end

  def maleWaitlist do
    header = ["Men Waiting"]
    rows = malesWaiting()

    TableRex.quick_render!(rows, header)
    |> IO.puts()
  end

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
