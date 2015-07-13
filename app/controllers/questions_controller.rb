class QuestionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @total = Userquestion.where(user_id: current_user.id).count
  end

  def show
      @stats = Userquestionstat.find_by user_id: current_user.id
  end

  def update
    @userquestionstat = Userquestionstat.find_or_create_by!(user_id: current_user.id)
    @userquestionstat.total_questions += 1
    @userquestionstat.save
  end

  def correct
    @userquestionstat = Userquestionstat.find_or_create_by!(user_id: current_user.id)
    @userquestionstat.correct += 1
    @userquestionstat.save
  end

  def incorrect
    @userquestionstat = Userquestionstat.find_or_create_by!(user_id: current_user.id)
    @userquestionstat.incorrect += 1
    @userquestionstat.save
  end

  def timedgame
  end

  def create
    @question = Question.new(question_params)
    @question.save
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
