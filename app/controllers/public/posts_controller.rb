class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
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
    #@posts = Post.all
    user_ids = current_user.followings.pluck(:id) # フォローしているユーザーのid一覧
    user_ids.push(current_user.id) # 自身のidを一覧に追加する
    @posts = Post.where(user_id: user_ids).order(created_at: :desc)
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path
    else
      render :new
    end
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
