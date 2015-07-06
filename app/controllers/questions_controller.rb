class QuestionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @total = Userquestion.where(user_id: current_user.id).count
  end

  def show
    @stats = Userquestionstat.find_or_create_by!(user_id: current_user.id)
  end

  def update
    @userquestionstat = Userquestionstat.find(user_id: current_user.id)
    @userquestionstat.increment!(:total_questions)
    redirect_to :root_path
  end
end
