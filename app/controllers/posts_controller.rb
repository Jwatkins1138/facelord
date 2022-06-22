class PostsController < ApplicationController

  def index
    @posts = Post.all.order( 'created_at DESC' )
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
