class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
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
end
