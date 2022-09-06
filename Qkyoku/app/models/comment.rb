class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :favorites
    has_many :execution_statuses
    has_one_attached :image

end
