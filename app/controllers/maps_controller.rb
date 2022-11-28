class MapsController < ApplicationController
  def index
    @locations = Location.all.paginate(page: params[:page])
  end
end
