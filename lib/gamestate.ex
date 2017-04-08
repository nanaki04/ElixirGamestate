defmodule Gamestate do
  use Supervisor

  def start_link do
    {:ok, supervisor} = Supervisor.start_link(__MODULE__, [])
    {:ok, agent} = Agent.start_link(fn -> %{} end)
    {supervisor, agent}
  end

  def init([]) do
    children = [
      worker(Gamestate, [], restart: :transient)
    ]
    supervise(children, strategy: :simple_one_for_one)
  end

  def add_substate({supervisor, agent}, name) do
    {:ok, substate} = Supervisor.start_child(supervisor, [])
    Agent.update(agent, &Map.put(&1, name, substate))
    substate
  end

  def get_substate({_supervisor, agent}, name) do
    Agent.get(agent, &Map.get(&1, name))
  end

  def update_value({_supervisor, agent}, name, value) do
    Agent.update(agent, &Map.put(&1, name, value))
  end

  def get_value({_supervisor, agent}, name) do
    Agent.get(agent, &Map.get(&1, name))
  end

end
