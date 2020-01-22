defmodule Balderdash.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :answer, :string
    field :incorrect_four, :string
    field :incorrect_one, :string
    field :incorrect_three, :string
    field :incorrect_two, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text, :answer, :incorrect_one, :incorrect_two, :incorrect_three, :incorrect_four])
    |> validate_required([:text, :answer, :incorrect_one, :incorrect_two, :incorrect_three, :incorrect_four])
  end
end
