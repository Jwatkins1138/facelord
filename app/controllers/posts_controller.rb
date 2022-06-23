class PostsController < ApplicationController

  def index
    if user_signed_in?
      @posts = Post.where(user_id: current_user.feed).order( 'created_at DESC' )
    else 
      @posts = Post.all.order( 'created_at DESC' )
    end    
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    @post.save
    redirect_to root_path
  end

  def add_like
    @post = Post.find(params[:id])
    @like = @post.post_likes.build
    @like.user_id = current_user.id
    @like.save
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
