class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
  	if current_user.manager? or current_user.admin?
      @assignments = Assignment.order("start_datetime DESC").page(params[:page]).per(10)
    else
      @assignments = Assignment.where(' worker_user_id = ? ', current_user.id ).order("start_datetime DESC").page(params[:page]).per(10)
    end

  end
end
