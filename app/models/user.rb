class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #class_nameでRelationshipモデルを読み込み、foreign_keyでカラムを参照する
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy

  #一覧画面を表示する為のアソシエーション
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, {length: {maximum: 50}}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


  #フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  #フォローを外したときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end



  #検索方法分岐
  def self.search_for(search, word)
    if search == 'perfect_match'
      @users = User.where("name LIKE?", "#{word}")
    elsif search == 'forward_match'
      @users = User.where("name LIKE?", "#{word}%")
    elsif search == 'backward_match'
      @users = User.where("name LIKE?", "%#{word}")
    elsif search == 'partial_match'
      @users = User.where("name LIKE?", "%#{word}%")
    else
      @users = User.all
    end
  end







end

