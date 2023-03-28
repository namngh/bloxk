defmodule Bloxk.Node do
  use GenServer

  defstruct owner_address: nil

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def list_block_hashes() do
    GenServer.call(__MODULE__, :list_block_hashes)
  end

  def get_block(block_hash) do
    GenServer.call(__MODULE__, {:get_block, block_hash})
  end

  def new_command(command) do
    GenServer.cast(__MODULE__, {:new_command, command})
  end

  def mine() do
    GenServer.cast(__MODULE__, :mine)
  end

  @impl true
  def init(_) do
    genesis_block = Bloxk.Block.create_genesis()
    genesis_block_hash = Bloxk.Block.hash(genesis_block)

    {:ok,
     %{
       block_hashes: [genesis_block_hash],
       blocks: %{genesis_block_hash => Bloxk.Block.create_genesis()},
       commands: []
     }}
  end

  @impl true
  def handle_call(
        :list_block_hashes,
        _from,
        %{block_hashes: block_hashes} = state
      ) do
    {:reply, block_hashes, state}
  end

  @impl true
  def handle_call(
        {:get_block, block_hash},
        _from,
        %{blocks: blocks} = state
      ) do
    {:reply, blocks |> Map.get(block_hash), state}
  end

  @impl true
  def handle_cast(
        {:new_command, command},
        %{commands: commands} = state
      ) do
    {:noreply, %{state | commands: [command | commands]}}
  end

  @impl true
  def handle_cast(
        :mine,
        %{block_hashes: [last_block_hash | _] = block_hashes, blocks: blocks, commands: commands} =
          state
      ) do
    block = Bloxk.Block.create_next(blocks |> Map.get(last_block_hash), commands)
    block_hash = Bloxk.Block.hash(block)

    {:noreply,
     %{
       state
       | blocks: blocks |> Map.put(block_hash, block),
         block_hashes: [block_hash | block_hashes]
     }}
  end
end
