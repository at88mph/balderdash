defmodule Balderdash.Repo.Migrations.AddLastReadColumn do
  use Ecto.Migration

  def change do
    alter table(:questions) do
      add :last_read_at, :timestamp
    end
  end
end
