class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @post.post_tags.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def index
    @posts = Post.all

  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def tag
    @user = current_user
    @tag = Tag.find_by(tag_name: params[:name])
    @posts = @tag.posts
  end


  private

  def post_params
    params.require(:post).permit(:title, :image, :body, :tag_body, :user_id, :is_deleted, post_images_images: [], tag_ids: [])
  end
end
