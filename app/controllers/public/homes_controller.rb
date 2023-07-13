class Public::HomesController < ApplicationController
  def top
    #@posts = Post.where(user_id: [current_user.id, *current_user.following_ids])
  end
end
