class ToppagesController < ApplicationController
  def index
    if logged_in?
      @pagy, @places = pagy(current_user.places.order(id: :desc))
    end
  end
end
