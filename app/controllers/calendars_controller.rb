class CalendarsController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper

  def create
    date_from = Date.parse(calendar_params[:start_date])
    date_to = Date.parse(calendar_params[:end_date])

    (date_from..date_to).each do |date|
      calendar = Calendar.where(location_id: params[:location_id], day: date)

      if calendar.present?
        calendar.update_all(price: calendar_params[:price], status: calendar_params[:status])
      else
        Calendar.create(
          location_id: params[:location_id],
          day: date,
          price: calendar_params[:price],
          status: calendar_params[:status]
        )
      end
    end

    redirect_to host_calendar_path
    #redirect_to assignment_calendar_path
  end

  def host
    @locations = Location.all
    @works = Master.work.all

    params[:start_date] ||= Date.current.to_s
    params[:location_id] ||= @locations[0] ? @locations[0].id : 2 # nil
    params[:work_id] ||= @works[0] ? @works[0].id : 2 

    #if params[:q].present?
    #  params[:start_date] = params[:q][:start_date]
    #  params[:location_id] = params[:q][:location_id]
    #end

    # @search = Reservation.ransack(params[:q])

    if params[:location_id]
      @location = Location.find(params[:location_id])
      start_date = Date.parse(params[:start_date])

      first_of_month = (start_date - 1.months).beginning_of_month # => Jun 1
      end_of_month = (start_date + 1.months).end_of_month # => Aug 31

      @events = @location.duties.joins(:user)
                      .select('duties.*, users.*')
                      .where('(start_date BETWEEN ? AND ?) ', first_of_month, end_of_month)
      @events.each{ |e| e.image = avatar_url(e) }
      @days = Calendar.where("location_id = ? AND day BETWEEN ? AND ?", params[:location_id], first_of_month, end_of_month)
    else
      @location = nil
      @events = []
      @days = []
    end
  end

  def assignment

  end

  private
    def calendar_params
      params.require(:calendar).permit([:price, :status, :start_date, :end_date])
    end
end