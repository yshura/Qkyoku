class User < ApplicationRecord
  has_many :posts
  has_many :checks, dependent: :destroy
  has_many :comments
  has_many :favorites
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
         
  def self.guest
    # ゲストユーザーを削除されてゲスト機能が動作しなくなるリスク回避
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.email = 'guest@example.com'
    end
  end
end
