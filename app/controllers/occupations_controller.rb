class OccupationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_occupation, only: [:show, :edit, :update, :destroy]

  def checkout
    @location = Location.find(params[:id])
    @location.Vacant!
    @location.save
    @location.occupations.last.Out!
    @location.occupations.last.checkout_datetime = Date.current  
    @location.occupations.last.save
    flash[:notice] = "Checkout successfully!"
    redirect_to @location
  end

  # GET /occupations
  # GET /occupations.json
  def index
    @occupations = Occupation.all
  end

  # GET /occupations/1
  # GET /occupations/1.json
  def show
  end

  # GET /occupations/new
  def new
    @occupation = Occupation.new
  end

  # GET /occupations/1/edit
  def edit
  end

  # POST /occupations
  # POST /occupations.json
  def create

    @occupation = Occupation.new(occupation_params)
    @occupation.checkin_datetime = Time.zone.now   
    days = (@occupation.due_date - Date.today).to_i 
    @occupation.price = 150
    @occupation.total = @occupation.price *  days 

    location = Location.find(params[:location_id]) 
    @occupation.location_id  = location.id 
    @occupation.In! 

    @occupation.save
    flash[:notice] = "Checkin successfully!"
    redirect_to location

  end

  # PATCH/PUT /occupations/1
  # PATCH/PUT /occupations/1.json
  def update
    respond_to do |format|
      if @occupation.update(occupation_params)
        format.html { redirect_to @occupation.location, notice: 'Occupation was successfully updated.' }
        format.json { render :show, status: :ok, location: @occupation }
      else
        format.html { render :edit }
        format.json { render json: @occupation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occupations/1
  # DELETE /occupations/1.json
  def destroy
    @occupation.destroy
    respond_to do |format|
      format.html { redirect_to occupations_url, notice: 'Occupation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occupation
      @occupation = Occupation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def occupation_params
      params.require(:occupation).permit(:location_id, :checkin_datetime, :due_date, :checkout_datetime, :customer, :passport, :price, :total, :status)
    end
end
