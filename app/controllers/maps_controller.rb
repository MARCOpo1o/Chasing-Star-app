class MapsController < ApplicationController
  def index
    @locations = Location.all.paginate(page: params[:page])
    @pins = Location.all
  end
end
