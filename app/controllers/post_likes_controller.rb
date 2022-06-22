class PostLikesController < ApplicationController

  def new
    @post_like = PostLike.new
  end

  def create
    @post_like = PostLike.new(post_like_params)
    @post_like.save
    redirect_to root_path 
  end

  private 

  def post_like_params
    params.require(:post_like).permit(:post_id, :user_id)
  end
end
