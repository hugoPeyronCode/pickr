class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @home
    # if user_signed_in?
    #   redirect_to decks_path
    # end
  end
end
