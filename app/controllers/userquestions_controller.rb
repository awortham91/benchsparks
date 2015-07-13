class UserquestionsController < ApplicationController
  before_action :authenticate_user!
  def create
    question = Question.find_or_create_by!(body: params[:body])
    userquestion = Userquestion.new(user_id: current_user.id, question_id: question.id , answer: params[:answer])
    if userquestion.save
      digits = params[:body].split(" ")
      if digits.first.to_i * digits.last.to_i == params[:answer].to_i
        render json: { statusText: "correct" }
      else
        render json: { statusText: "incorrect" }
      end
    else
      render json: {statusText: "Boooo!"}
    end
  end
end
