class Section < ApplicationRecord
  has_many :posts , dependent: :destroy

      # 未読件数カウント
  def count_unread_by_user(user)
    posts.where(
      'NOT EXISTS(:checks)',
      checks: Check.select(1).where(user_id: user.id).where('posts.id = checks.post_id')
    ).where.not(user_id: user.id).count
  end
  
  has_one_attached :image
end
