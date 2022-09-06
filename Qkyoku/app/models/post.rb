class Post < ApplicationRecord
    has_many :comments
    has_many :checks
    belongs_to :user
    belongs_to :section
    has_one_attached :image

end
