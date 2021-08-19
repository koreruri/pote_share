class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_one_attached :image
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 },
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                        message: "jpeg,gif,pngファイルのいずれかを選択して下さい" },
                    size: { less_than: 5.megabytes,
                        message: "画像ファイルサイズは5MB以下にして下さい" }
  
  #users/editで画像、紹介がないとエラーになるのでpresenceバリデーションは無し
  # validates :image, presence: true, on: :update
  # validates :introduction, presence: true, on: :update
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # アイコン用のリサイズ済み画像を返す
  def icon_image
    image.variant(resize_to_limit: [500, 500])
  end
end
