class UsersController < ApplicationController
  
  after_create :send_welcome

  def show
    @user = User.find(params[:id])
  end

  def index
    @search = params['search']
    if @search.present?
      @users = User.where('name = ?', @search['name'])
    else
      @users = (User.all.excluding(current_user.friends, current_user))
    end
  end

  def friends_index
    @user = User.find(params[:user_id])
    @friends = @user.friends 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update((user_params))
    redirect_to user_path(@user)
    UserMailer.with(user: @user).welcome_email.deliver_later
  end

  def send_welcome
    @user = curent_user
    UserMailer.with(user: @user).welcome_email.deliver_later
  end

  def request_friend
    @friend = User.find(params[:id])
    @request = Friendship.new
    @request.status = 'pending'
    @request.inviter = current_user
    @request.accepter = @friend
    @request.save
    redirect_to root_path
  end

  def accept_friend
    @request = Friendship.find(params[:id])
    @request.status = 'accepted'
    @request.save
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :location, :birthday, :company)
  end
end
