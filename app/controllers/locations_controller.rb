class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]
  before_action :admin_user,     only: :edit

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
    @location = Location.find(params[:id])
    @average_rate = @location.posts.length.positive? ? @location.posts.average(:rate).round(1) : 0
    @date = params[:date] == nil ? Date.today : Date.parse(params[:date])
    @date_diff = (@date - Date.today).to_i >= 0 ? (@date - Date.today).to_i : 0
    @cloudCover = @date_diff > 0 ? getWeatherForecast(@location, (@date_diff - 1) * 8) : getWeatherCurrent(@location) # a 0 param means 06:00 tomorrow, delta 1 means 3 hour's change, e.g. 8 means 06:00 the day after tomorrow
    # @weatherInfo = @date_diff > 0 ? getWeatherForecastInfo(@location, (@date_diff - 1) * 8) : Time.now
    @show_date = @date_diff > 0 ? Date.today + @date_diff : Date.today
    @bortleScale = @location.bortleScale.nil? ?  getLightPollution(@location) : @location.bortleScale
    @user = current_user
    @posts = @location.posts.paginate(page: params[:page])
    
    @score = starVisibility(@cloudCover, @bortleScale)
    session.delete(:return_to)
    session[:return_to] = request.original_url 
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    # @location.image.attach(params[:location][:image])
  end
 
  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to location_url(@location), notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def do_search
    @locations = Location.where("location_name ILIKE ?", "%#{params[:location_name]}%")
    @date = params[:date] == nil ? Date.today : Date.parse(params[:date])
    @date_diff = (@date - Date.today).to_i >= 0 ? (@date - Date.today).to_i : 0
    @show_date = @date_diff > 0 ? Date.today + @date_diff : Date.today 
    render :index
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:location_name, :average_rate, :image)
    end

    def admin_user
      redirect_to root_url, status: :see_other unless current_user && current_user.admin?
    end

      
end
 