class ToppagesController < ApplicationController
  def index
    if logged_in?
      @pagy, @places = pagy(current_user.feed_places.order(id: :desc), items: 5)
    end
  end
end
