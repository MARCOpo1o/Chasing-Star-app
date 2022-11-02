class MainPagesController < ApplicationController
  def home
  end

  def explore
  end

  def select_date
    @selected_date = params[:selected_date]
    flash.alert = @selected_date
  end
end
