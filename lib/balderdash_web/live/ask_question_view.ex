defmodule BalderdashWeb.AskQuestionView do
  use Phoenix.LiveView

  alias Balderdash.Questions
  alias BalderdashWeb.Router.Helpers, as: Routes

  def render(assigns) do
    BalderdashWeb.QuestionView.render("ask_live.html", assigns)
  end

  def mount(_params, session, socket) do
    {:ok, assign(socket, question: session["question"],
                         answers: session["answers"])}
  end

  def handle_event("check_answer", %{"changeset" => changeset, "answer" => answer} = params, socket) do
    # do the deploy process
    question = Questions.get_question!(String.to_integer(changeset["question_id"]))

    answers = []
    Enum.filter(params, fn {k, _v} -> not String.starts_with?(k, "answer_index_") end)
    |> Enum.each(fn {k, v} -> List.insert_at(answers, Enum.at(String.split(k, "answer_index_"), 1)
                                                      |> String.to_integer(), v) end)

    {:noreply, assign(socket, question: question, answers: answers, submitted_answer: answer)}
  end
end
