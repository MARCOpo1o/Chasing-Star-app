class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user
    default_scope -> { order(created_at: :desc) }

    validates :user_id, presence: true
    validates :post_id, presence: true
    validates :message, presence: true, length: { maximum: 300 } 
    
end
