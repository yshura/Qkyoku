class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :checks, dependent: :destroy
    belongs_to :user
    belongs_to :section
    
    scope :latest, -> {order(created_at: :desc)}
    scope :old, -> {order(created_at: :asc)}
    
    validates :title, presence: :true
    validates :post_body, presence: :true
    
    has_one_attached :image

end
