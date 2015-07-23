class AdminsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.where(admin:true)
  end
end
