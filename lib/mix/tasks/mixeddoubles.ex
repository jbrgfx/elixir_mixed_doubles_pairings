defmodule Mix.Tasks.MixedDoubles do
  use Mix.Task

  @doc """
  Simply calls the MixedDoubles.assignCourt function.
  λ iex --werl -S mix mixed_doubles
  """
  def run(_) do
    MixedDoubles.assignCourts()
  end
end
