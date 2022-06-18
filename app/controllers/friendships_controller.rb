class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.save
  end
  private

  def friendship_params
    params.require(:friendship).permit(:inviting_friend_id, :accepting_friend_id)
  end
end
