class SearchesController < ApplicationController

  #コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @records = User.search_for(params[:search], params[:word])
    else
      @records = Book.search_for(params[:search], params[:word])
    end
  end


end
