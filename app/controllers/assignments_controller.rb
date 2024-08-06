class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :assign, :acknowledge, 
    :start, :finish, :accept, :reject, :complete]

  def acknowledge 
    @assignment.worker_user = current_user
    @assignment.acknowledge!
    redirect_to assignments_path(:aasm_state => "acknowledged") 
  end

  def quote
    @assignment.quote!
    redirect_to assignments_path(:aasm_state => "quoted")
  end

  def assign
    @assignment.assign!
    @assignment.contractor.users.each do |member|
      Notification.create(recipient: member, user: current_user, 
        notifiable_id: @assignment.id, notifiable_type: 'Assignment', 
        content: "#{Time.now.to_formatted_s(:db)}  #{@assignment.work.name} Job : #{@assignment.no} is assigned.")
    end    
    redirect_to assignments_path(:aasm_state => "assigned")
  end

  def start
    @assignment.start!
    redirect_to assignments_path(:aasm_state => "working") 
  end
 
  def finish
    @assignment.finish!
    Notification.create(recipient: @assignment.incharge_user, user: current_user, 
        notifiable_id: @assignment.id, notifiable_type: 'Assignment', 
        content: "#{Time.now.to_formatted_s(:db)}  #{@assignment.work.name} Job : #{@assignment.no} is ready for inspection. ")
    redirect_to assignments_path(:aasm_state => "finished") 
  end

  def accept
    @assignment.end_datetime = Time.zone.now
    @assignment.accept! 
    redirect_to assignments_path(:aasm_state => "completed") 
  end

  def reject 
    @assignment.reject!
    Notification.create(recipient: @assignment.worker_user, user: current_user, 
        notifiable_id: @assignment.id, notifiable_type: 'Assignment', 
        content: "#{Time.now.to_formatted_s(:db)}  #{@assignment.work.name} Job : #{@assignment.no} is rejected. ")
    redirect_to assignments_path(:aasm_state => "rejected") 
  end

  def complete 
    @assignment.end_datetime = Time.zone.now
    @assignment.complete!
    Notification.create(recipient: @assignment.incharge_user, user: current_user, 
        notifiable_id: @assignment.id, notifiable_type: 'Assignment', 
        content: "#{Time.now.to_formatted_s(:db)}  #{@assignment.work.name} Job : #{@assignment.no} is completed.")
    redirect_to assignments_path(:aasm_state => "completed") 
  end

  # GET /assignments
  # GET /assignments.json
  def search
      @search = Assignment.search(params[:q])
      @assignments = @search.result
      @assignments = Assignment.where(" start_datetime >= ? ", Date.yesterday ) unless params[:q]
  end

  # GET /assignments
  # GET /assignments.json
  def index
    if params[:commit] == "Search" or params[:commit] == "Summary" or params[:commit] == "Report"
      @search = Assignment.search(params[:q])
      @assignments = @search.result
      @assignments = Assignment.includes(:location, :work, :contractor, :worker_user, :incharge_user).where(" start_datetime >= ? ", Date.yesterday ) unless params[:q]
      @first = @assignments.first
      @last = @assignments.last
      @count = @assignments.count 
      if @count > 0 
        if params[:commit] == "Summary" 
          html = render_to_string(template: 'assignments/summary.pdf.erb', layout: 'layouts/application.pdf.erb')
          pdf = WickedPdf.new.pdf_from_string(html, :orientation => 'Landscape')
          send_data(pdf, filename: 'summary.pdf', type: 'application/pdf', disposition: :attachment )
        end
        if params[:commit] == "Report" 
          html = render_to_string(template: 'assignments/report.pdf.erb', 
              layout: 'layouts/application.pdf.erb')
          pdf = WickedPdf.new.pdf_from_string(html)
          send_data(pdf, filename: 'report.pdf', type: 'application/pdf', disposition: :attachment )
        end
      end
    else
      if current_user.manager? or current_user.admin?
        @assignments = Assignment.all
      else
        @assignments = Assignment.where("  contractor_id in (" + current_user.teams + " )" ) 
      end
      if params[:aasm_state].present?
        @assignments = @assignments.where(aasm_state: params[:aasm_state])
      end
      @assignments = @assignments.includes(:location, :work, :contractor, :worker_user, :incharge_user).order("start_datetime DESC").page(params[:page]).per(10)
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @photos = @assignment.photos

    respond_to do |format|
      format.html 

    end
  end 
 
  # GET /assignments/new
  def new
    if params[:parent_id]
      @assignment = Assignment.new(:parent_id => params[:parent_id])
    else
      @assignment = Assignment.new
    end
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.user = current_user
    @assignment.inspector ||= current_user 

    respond_to do |format|
      if @assignment.save
        if @assignment.date_range.blank?
          format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        else
          format.html { redirect_to assignment_calendar_path, notice: 'Assignment was successfully created.' }
        end
#        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        if @assignment.date_range.blank?
          format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
#          format.html { redirect_to assignment_calendar_path, notice: 'Assignment was successfully created.' }
        else
          format.html { redirect_to assignment_calendar_path }
#          redirect_to(:back)
#          format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    if @assignment.date_range.blank?
      respond_to do |format|
        format.html { redirect_to assignments_path(:commit => "Search"), notice: 'Assignment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to assignment_calendar_path }
    end
  end

  def import
    Assignment.import(params[:file])
    redirect_to assignments_path, notice: "Tasks imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.includes(:location, :work, :contractor, :worker_user, :incharge_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:work_id, :location_id, :incharge_user_id, :color, 
        :heading, :start_datetime, :status, :worker_user_id, :name, :task, :ancestry, 
        :date_range, :address, :contractor_id,  :work_order, :bim_url, :inspector_id, :witness_id,
        :reported, :followup,
        :due_datetime, :parent_id, :end_datetime, :user_ref, :remarks, :star, :comment, photos: [])
    end
end
