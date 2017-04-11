defmodule Import do

  def load_gamestate(gamestate, options) do
    raw_gamestate = get_data gamestate, options
    import_gamestate gamestate, raw_gamestate
  end

  def import_gamestate(gamestate, [{_, _} | _] = gameData) do
    Enum.each(gameData, fn(dataBlock) -> parse(gamestate, dataBlock) end)
  end

  defp get_data(gamestate, options) do
    game_id = Gamestate.get_value gamestate, :game_id
    user_data = options[:user_data]
    user_data.get_gamestate game_id
  end

  defp parse(gamestate, {name, [{_, _} | _] = value}) do
    {:ok, substate} = Gamestate.start_link(name)
    set_value(gamestate, name, substate)
    import_gamestate(substate, value)
  end

  defp parse(gamestate, {name, value}) do
    set_value(gamestate, name, value)
  end

  defp set_value(gamestate, name, value) do
    Gamestate.update_value(gamestate, name, value)
  end

end
