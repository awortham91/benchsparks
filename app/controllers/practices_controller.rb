class PracticesController < ApplicationController
  before_action :authenticate_user!

  def index
    @total = Userquestion.where(user_id: current_user.id).count
  end


end
