class UsersController < ApplicationController
  def new

  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)  
    if @user.save
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end
end
