class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :favorites, dependent: :destroy
    belongs_to :execution_status
    
    validates :comment_body, presence: :true
    
    has_one_attached :image
    
    def favorited_by(user)
       favorites.find_by(user_id: user.id)
    end

end
