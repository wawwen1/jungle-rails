class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    #if user exists + password correct
    if user && user.authenticate(params[:password])
      #save user in cookie -> keeps user logged in while navigating
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
