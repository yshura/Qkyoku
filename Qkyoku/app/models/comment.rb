class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :favorites, dependent: :destroy
  belongs_to :execution_status
  has_many :notifications, dependent: :destroy
  
  validates :comment_body, presence: :true
  
  has_one_attached :image
  
  def favorited_by(user)
     favorites.find_by(user_id: user.id)
  end
  
  def create_notification_comment(current_user)
    notification = current_user.active_notifications.new(
      comment_id: id,
      visited_id: post.user_id,
      action: 'comment'
    )
    notification.save if notification.valid?
  end
	
	def create_notification_favorite(current_user)
    notification = current_user.active_notifications.new(
      favorite_id: id,
      visited_id: comment.user_id,
      action: 'favorite'
    )
    notification.save if notification.valid?
	end

end
