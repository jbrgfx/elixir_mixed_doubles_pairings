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
    divisible_by_4? = fn n -> rem(n, 4) == 0 end
    teams = for n <- 1..lesserCount(), divisible_by_4?.(n), do: n
    _maxTeams = Enum.max(teams)
  end

  def shuffleFemales do
    # IO.puts(lesserCount())
    females() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  def shuffleMales do
    # IO.puts(lesserCount())
    males() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  def assignTeams do
    shuffleFemales() |> Enum.zip(shuffleMales())
  end

  # take remainder and add to waitlist
  def femalesWaiting do
    cntFemale = Enum.count(females())
    fw = Enum.slice(females(), numberOfTeams(), cntFemale)
    for n <- fw, do: [n]
  end

  def femaleWaitlist do
    title = "Ladies Waiting"
    header = ["Name"]

    rows = femalesWaiting()

    TableRex.quick_render!(rows, header, title)
    |> IO.puts()
  end

  def malesWaiting do
    cntMale = Enum.count(males())
    mw = Enum.slice(males(), numberOfTeams(), cntMale)
    for n <- mw, do: [n]
  end

  def maleWaitlist do
    title = "Men Waiting"
    header = ["Name"]

    rows = malesWaiting()

    TableRex.quick_render!(rows, header, title)
    |> IO.puts()
  end

  def assignCourts do
    court1 = Enum.slice(assignTeams(), 0..1)
    court2 = Enum.slice(assignTeams(), 2..3)
    court3 = Enum.slice(assignTeams(), 4..5)
    court4 = Enum.slice(assignTeams(), 6..7)

    IO.puts("\nCourt 1:")
    IO.inspect(court1)
    IO.puts("\nCourt 2:")
    IO.inspect(court2)
    IO.puts("\nCourt 3:")
    IO.inspect(court3)
    IO.puts("\nCourt 4:")
    IO.inspect(court4)
    IO.puts("\n")
    femaleWaitlist()
    maleWaitlist()
  end
end
