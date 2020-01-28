defmodule BalderdashWeb.QuestionController do
  use BalderdashWeb, :controller

  alias Balderdash.Questions
  alias Balderdash.Questions.Question
  alias Phoenix.LiveView

  def index(conn, _params) do
    questions = Questions.list_questions()
    render(conn, "index.html", questions: questions)
  end

  def new(conn, _params) do
    changeset = Questions.change_question(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Random question chooser.  This will also render the "ask" page.
  """
  def random(conn, params) do
    question = Questions.random_question()
    answers = Enum.shuffle([question.answer, question.incorrect_one, question.incorrect_two, question.incorrect_three, question.incorrect_four])
    LiveView.Controller.live_render(conn, BalderdashWeb.AskQuestionView, 
                                    session: %{"question" => question, "answers" => answers, "submit_button_text" => "Check answer"})
    # render(conn, "ask.html", question: question)
  end

  def check_answer(conn, %{"id" => id, "answer" => submitted_answer} = params) do
    question = Questions.get_question!(id)
    answer_list = []

    params
    |> Enum.each(fn {k, v} -> List.insert_at(answer_list, String.l, v) end)

    match_params = Map.put(%{}, "match", (submitted_answer == question.answer)) 
    |> Map.put("question", question)

    answer_match(conn, match_params)
  end

  defp answer_match(conn, %{"match" => match, "question" => question} = params) when match == true do
    render(conn, "check.html", question: question)
  end

  defp answer_match(conn, %{"match" => match, "question" => question} = params) do
    render(conn, "check.html", question: question)
  end  

  def create(conn, %{"question" => question_params}) do
    case Questions.create_question(question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    render(conn, "show.html", question: question)
  end

  def edit(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    changeset = Questions.change_question(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Questions.get_question!(id)

    case Questions.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    {:ok, _question} = Questions.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: Routes.question_path(conn, :index))
  end
end
