class WelcomeController < ApplicationController

  layout "external"

  def index

  end

  def show
    @name = params[:name]
  end

  def hello

  end

end
