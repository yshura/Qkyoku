class ExecutionStatus < ApplicationRecord
    has_many :comments, dependent: :destroy
end
