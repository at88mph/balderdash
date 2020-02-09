defmodule BalderdashWeb.AskQuestionView do
  use Phoenix.LiveView

  alias Balderdash.Questions

  def render(assigns) do
    BalderdashWeb.QuestionView.render("ask_live.html", assigns)
  end

  def mount(_params, session, socket) do
    {:ok, assign(socket, question: session["question"],
                         answer_decorations: session["answer_decorations"],
                         check_message: session["check_message"],
                         answers: session["answers"])}
  end

  def handle_event("check_answer", %{"changeset" => changeset, "answer" => answer} = params, socket) do
    # do the deploy process
    question = Questions.get_question!(String.to_integer(changeset["question_id"]))

    answers = Enum.filter(params, fn {k, _v} -> String.starts_with?(k, "answer_index_") end)
              |> List.keysort(0)
              |> Enum.map(fn {_k, v} -> v end)

    check_message = cond do
                      answer == question.answer ->
                        "Correct!"
                      true ->
                        "Incorrect.  Try again."
                    end

    answer_decorations = answers
                         |> Enum.map(fn a -> cond do
                                               a == question.answer ->
                                                 "text-success font-weight-bold"
                                               answer == a ->
                                                 "text-danger font-weight-bold"
                                               true ->
                                                 ""
                                             end
                                     end)

    {:noreply, assign(socket, question: question, answers: answers, answer_decorations: answer_decorations, check_message: check_message)}
  end
end
