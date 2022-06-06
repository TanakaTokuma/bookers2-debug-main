class SearchesController < ApplicationController

  #コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end


end
