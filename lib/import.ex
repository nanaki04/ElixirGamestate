defmodule Import do

  def import_data(gamestate, [{_, _} | _] = gameData) do
    Enum.each(gameData, fn(dataBlock) -> parse(gamestate, dataBlock) end)
  end

  defp parse(gamestate, {name, [{_, _} | _] = value}) do
    {:ok, substate} = Gamestate.start_link(name)
    set_value(gamestate, name, substate)
    import_data(substate, value)
  end

  defp parse(gamestate, {name, value}) do
    set_value(gamestate, name, value)
  end

  defp set_value(gamestate, name, value) do
    Gamestate.update_value(gamestate, name, value)
  end

end
