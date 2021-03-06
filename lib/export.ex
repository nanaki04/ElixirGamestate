defmodule Export do

  def save_gamestate(gamestate, options) do
    converted_data = convert_data gamestate, options
    user_data = options[:userdata]
    game_id = Gamestate.get_value gamestate, :game_id
    user_data.save_gamestate game_id, converted_data
  end

  def export_gamestate(gamestate, options) do
    converted_data = convert_data gamestate, options
    IO.inspect converted_data
    converted_data
  end

  defp convert_data(gamestate, options) do
    exportedData = Gamestate.get_all(gamestate)

    iterator = fn
      {key, value} when is_pid(value) -> {key, export_gamestate(value, options)}
      entry -> entry
    end

    Enum.map(exportedData, iterator)
  end

end
