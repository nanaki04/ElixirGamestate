defmodule Mock.UserData do

  def save_gamestate(_game_id, _exported_gamestate), do: {:ok}
  def get_gamestate(_game_id), do: [game_id: "1234", isles: [brimstone: {1, 1}]]

end
