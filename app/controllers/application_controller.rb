class ApplicationController < ActionController::Base
    include SessionsHelper

    private

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url, status: :see_other
        end
    end

    def select_date
        flash.alert = "test"
        @selected_date = params[:selected_date]
        flash.alert = @selected_date
      end
end
