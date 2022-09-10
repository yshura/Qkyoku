class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :checks, dependent: :destroy
    belongs_to :user
    belongs_to :section
    
    validates :title, presence: :true
    validates :post_body, presence: :true
    
    has_one_attached :image

end
