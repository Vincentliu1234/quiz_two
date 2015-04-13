class ContactController < ApplicationController

  

  def index
    

  end

  def create
    @name    = params[:full_name]
    @email   = params[:email]
    @message = params[:message]
  end


end
