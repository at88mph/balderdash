defmodule Balderdash.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :text, :string
      add :answer, :string
      add :incorrect_one, :string
      add :incorrect_two, :string
      add :incorrect_three, :string
      add :incorrect_four, :string

      timestamps()
    end

  end
end
