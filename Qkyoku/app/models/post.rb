class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :checks, dependent: :destroy
    belongs_to :user
    belongs_to :section
    has_one_attached :image

end
