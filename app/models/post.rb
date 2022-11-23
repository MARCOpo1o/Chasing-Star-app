class Post < ApplicationRecord
    belongs_to :user
    belongs_to :location
    has_one_attached :image do |attachable|
        attachable.variant :display, resize_to_limit: [500, 500]
    end
    has_many :photos, dependent: :destroy
    has_many :comments, dependent: :destroy
    default_scope -> { order(created_at: :desc) }

    validates :user_id, presence: true
    validates :location_id, presence: true
    validates :message, presence: true, length: { maximum: 300 } 
    validates :rate, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5,  only_integer: true }
    validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                        message: "must be a valid image format" },
                        size:         { less_than: 5.megabytes,
                                        message:   "should be less than 5MB" }
    
end
