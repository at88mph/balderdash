defmodule Balderdash.QuestionsTest do
  use Balderdash.DataCase

  alias Balderdash.Questions

  describe "questions" do
    alias Balderdash.Questions.Question

    @valid_attrs %{answer: "some answer", incorrect_four: "some incorrect_four", incorrect_one: "some incorrect_one", incorrect_three: "some incorrect_three", incorrect_two: "some incorrect_two", text: "some text"}
    @update_attrs %{answer: "some updated answer", incorrect_four: "some updated incorrect_four", incorrect_one: "some updated incorrect_one", incorrect_three: "some updated incorrect_three", incorrect_two: "some updated incorrect_two", text: "some updated text"}
    @invalid_attrs %{answer: nil, incorrect_four: nil, incorrect_one: nil, incorrect_three: nil, incorrect_two: nil, text: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Questions.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Questions.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Questions.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Questions.create_question(@valid_attrs)
      assert question.answer == "some answer"
      assert question.incorrect_four == "some incorrect_four"
      assert question.incorrect_one == "some incorrect_one"
      assert question.incorrect_three == "some incorrect_three"
      assert question.incorrect_two == "some incorrect_two"
      assert question.text == "some text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Questions.update_question(question, @update_attrs)
      assert question.answer == "some updated answer"
      assert question.incorrect_four == "some updated incorrect_four"
      assert question.incorrect_one == "some updated incorrect_one"
      assert question.incorrect_three == "some updated incorrect_three"
      assert question.incorrect_two == "some updated incorrect_two"
      assert question.text == "some updated text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question(question, @invalid_attrs)
      assert question == Questions.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Questions.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Questions.change_question(question)
    end
  end
end
