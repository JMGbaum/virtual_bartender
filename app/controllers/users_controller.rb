class UsersController < ApplicationController
  before_action :authorize, only: %i[edit]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  # def index
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end
  private

    def authorize
      redirect_to(request.headers["Referer"]) unless logged_in?
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :birthday, :country, :email, :password,
                                   :password_confirmation)
    end
end
