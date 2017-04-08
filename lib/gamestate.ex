defmodule Gamestate do

  def start_link(name) do
    Agent.start_link(fn -> %{name: name} end)
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

end
