defmodule Bloxk.Block do
  defstruct proposer_ip: nil, parent_root: nil, commands: [], full_at: nil, mined_at: nil

  def hash(%__MODULE__{} = block) do
    :crypto.hash(:sha256, Jason.encode!(block)) |> Base.encode16()
  end

  def create_genesis() do
    %__MODULE__{commands: [%{contract_address: :genesis, data: "Genesis Block"}]}
  end

  def create_next(last_block, commands) do
    %__MODULE__{parent_root: hash(last_block), commands: commands}
  end
end
