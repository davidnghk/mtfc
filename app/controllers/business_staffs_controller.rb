class BusinessStaffsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business_staff, only: [:show, :edit, :update, :destroy]

  # GET /business_staffs
  # GET /business_staffs.json
  def index
    @business_staffs = BusinessStaff.order("business_unit_id")
  end

  # GET /business_staffs/1
  # GET /business_staffs/1.json
  def show
  end

  # GET /business_staffs/new
  def new
    @business_staff = BusinessStaff.new
  end

  # GET /business_staffs/1/edit
  def edit
  end

  # POST /business_staffs
  # POST /business_staffs.json
  def create
    @business_staff = BusinessStaff.new(business_staff_params)

    respond_to do |format|
      if @business_staff.save
        format.html { redirect_to @business_staff, notice: 'Business staff was successfully created.' }
        format.json { render :show, status: :created, location: @business_staff }
      else
        format.html { render :new }
        format.json { render json: @business_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_staffs/1
  # PATCH/PUT /business_staffs/1.json
  def update
    respond_to do |format|
      if @business_staff.update(business_staff_params)
        format.html { redirect_to @business_staff, notice: 'Business staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @business_staff }
      else
        format.html { render :edit }
        format.json { render json: @business_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_staffs/1
  # DELETE /business_staffs/1.json
  def destroy
    @business_staff.destroy
    respond_to do |format|
      format.html { redirect_to business_staffs_url, notice: 'Business staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_staff
      @business_staff = BusinessStaff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_staff_params
      params.require(:business_staff).permit(:business_unit_id, :post_id, :user_id)
    end
end
