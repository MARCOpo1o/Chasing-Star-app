class MapsController < ApplicationController
  def index
    @locations = Location.all.paginate(page: params[:page])
    @pins = Location.all
  end

  def recommend
    @locations = Location.all
    
  end
end
