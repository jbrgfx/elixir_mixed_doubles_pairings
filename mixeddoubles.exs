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

  # interleave the two lists to form teams
  def combinePlayers do
    interleave(shuffleFemales(), shuffleMales())
  end

  # see https://elixir-lang.org/blog/2013/12/11/elixir-s-new-continuable-enumerators/
  def interleave(a, b) do
    step = fn x, acc -> { :suspend, [x | acc] } end
    af = &Enumerable.reduce(a, &1, step)
    bf = &Enumerable.reduce(b, &1, step)
    do_interleave(af, bf, []) |> :lists.reverse()
  end

  defp do_interleave(a, b, acc) do
    case a.({ :cont, acc }) do
      { :suspended, acc, a } ->
        case b.({ :cont, acc }) do
          { :suspended, acc, b } ->
            do_interleave(a, b, acc)
          { :halted, acc } ->
            acc
          { :done, acc } ->
            finish_interleave(a, acc)
        end
      { :halted, acc } ->
        acc
      { :done, acc } ->
        finish_interleave(b, acc)
    end
  end

  defp finish_interleave(a_or_b, acc) do
    case a_or_b.({ :cont, acc }) do
      { :suspended, acc, a_or_b } ->
        finish_interleave(a_or_b, acc)
      { _, acc } ->
        acc
    end
  end

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
