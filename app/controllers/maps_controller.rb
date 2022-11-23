class MapsController < ApplicationController
  def index
    @locations = Location.all
  end
end
