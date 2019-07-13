defmodule MixedDoubles do

  def females do
    [{:name, "Alice", :gender, "F"},
     {:name, "Lynda", :gender, "F"},
     {:name, "Carol", :gender, "F"},
     {:name, "Kelly", :gender, "F"},
     {:name, "Dorothy", :gender, "F"},
     {:name, "Beth", :gender, "F"},
     {:name, "Jane", :gender, "F"},
     {:name, "Barb", :gender, "F"},
     {:name, "Molly", :gender, "F"},
     {:name, "Polly", :gender, "F"},
     {:name, "Joan", :gender, "F"}];
  end

  def males do
    [{:name, "John", :gender, "M"},
     {:name, "Kevin", :gender, "M"},
     {:name, "Dave", :gender, "M"},
     {:name, "Rocky", :gender, "M"},
     {:name, "Robert", :gender, "M"},
     {:name, "Ben", :gender, "M"},
     {:name, "Jim", :gender, "M"},
     {:name, "Brian", :gender, "M"},
     {:name, "Jon", :gender, "M"},
     {:name, "Kelly", :gender, "M"},
     {:name, "Peter", :gender, "M"},
     {:name, "Chris", :gender, "M"}];
  end

  # TODO: get size of each list and compare the two counts and
  #       take approp nmbr (8, 6, 4, 2) of the smaller list
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
  # waitlists and the number of players to shuffle
  def numberOfTeams do
    divisible_by_4? = fn(n) -> rem(n, 4) == 0 end
    teams = for n <- 1..lesserCount(), divisible_by_4?.(n), do: n
    _maxTeams = Enum.max(teams)
  end

  def shuffleFemales do
    IO.puts(lesserCount())
    females() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  def shuffleMales do
    IO.puts(lesserCount())
    males() |> Enum.take(numberOfTeams()) |> Enum.shuffle()
  end

  # TODO: pair the two lists to form teams
  # TODO: assign teams to courts

  # take remainder and add to waitlist
  def femalesWaitlist do
    cntFemale = Enum.count(females())
    _waitingLadies = Enum.slice(females(), numberOfTeams(), cntFemale)
  end

  def malesWaitlist do
    cntMale = Enum.count(males())
    _waitingMen = Enum.slice(males(), numberOfTeams(), cntMale)
  end

end
