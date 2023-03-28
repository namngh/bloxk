defmodule Bloxk.ContractDb do
  use GenServer

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast(
        {:insert, %{address: address, code: code, arguments: arguments}},
        contract_db
      ) do
    {:noreply, contract_db |> Map.put(address, %{code: code, arguments: arguments})}
  end

  @impl true
  def handle_call(
        {:execute, contract_address},
        _from,
        contract_db
      ) do
    {:reply, contract_db |> Map.get(contract_address), contract_db}
  end
end
