class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # Add any logic needed for the home page
  end
end

