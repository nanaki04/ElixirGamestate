defmodule Export do

  def export_gamestate(gamestate) do
    exportedData = Gamestate.get_all(gamestate)

    iterator = fn
      {key, value} when is_pid(value) -> {key, export_gamestate(value)}
      entry -> entry
    end

    Enum.map(exportedData, iterator)
  end

end
