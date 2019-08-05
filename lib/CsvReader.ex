defmodule CsvReader do
  def readFemales() do
    CSVLixir.read("data/females.csv")
    |> Enum.to_list()
  end

  def readMales() do
    CSVLixir.read("data/males.csv")
    |> Enum.to_list()
  end
end
