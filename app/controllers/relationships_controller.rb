class RelationshipsController < ApplicationController

  #userモデルにクリエイト時(フォローする時)の処理を記載
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  #userモデルにデストロイ時(フォロー外す時)の処理を記載
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  #フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  #フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
