class User < ApplicationRecord
  has_many :posts
  has_many :checks, dependent: :destroy
  has_many :comments
  has_many :favorites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    # ゲストユーザーを削除されてゲスト機能が動作しなくなるリスク回避
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
