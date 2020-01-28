defmodule BalderdashWeb.AskQuestionView do
  use Phoenix.LiveView

  alias Balderdash.Questions
  alias Balderdash.Questions.Question

  def render(assigns) do
    BalderdashWeb.QuestionView.render("ask_live.html", assigns)
  end

  def mount(_params, session, socket) do
    {:ok, assign(socket, question: session["question"], answers: session["answers"], submit_button_text: session["submit_button_text"])}
  end

  def handle_event("check_answer", %{"changeset" => changeset, "answer" => answer}, socket) do
    # do the deploy process
    question = Questions.get_question!(String.to_integer(changeset["question_id"]))

    button_text = cond do
                    question.answer == answer ->
                      "Correct!"
                    true ->
                      "Incorrect."
                  end

    {:noreply, assign(socket, submit_button_text: button_text )}
  end  
end