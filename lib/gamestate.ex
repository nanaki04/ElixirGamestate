defmodule Gamestate do

  def start_link(name) do
    Agent.start_link(fn -> %{name: name} end)
  end

  def start_link(game_id, options, link_options) do
    {:ok, gamestate} = Agent.start_link(fn -> %{game_id: game_id} end, link_options)
    load_gamestate gamestate, options
    {:ok, gamestate}
  end

  def update_value(gamestate, name, value) do
    Agent.update(gamestate, &Map.put(&1, name, value))
  end

  def get_value(gamestate, name) do
    Agent.get(gamestate, &Map.get(&1, name))
  end

  def get_all(gamestate) do
    Agent.get(gamestate, &(&1))
  end

  def export_gamestate(gamestate, options) do
    Export.export_gamestate gamestate, options
  end

  def save_gamestate(gamestate, options) do
    Export.save_gamestate gamestate, options
  end

  def load_gamestate(gamestate, options) do
    Import.load_gamestate gamestate, options
  end

  def import_gamestate(gamestate, raw_gamedata) do
    Import.import_gamestate gamestate, raw_gamedata
  end

end
