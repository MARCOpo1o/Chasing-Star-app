class Post < ApplicationRecord
    belongs_to :user
    belongs_to :location
    has_many :photos, dependent: :destroy
    has_many :comments, dependent: :destroy
    default_scope -> { order(created_at: :desc) }
    validates :user_id, presence: true
    validates :location_id, presence: true
    validates :message, presence: true, length: { maximum: 300 }
end
