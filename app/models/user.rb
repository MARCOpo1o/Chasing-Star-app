class User < ApplicationRecord
    has_many :user_locations
    has_many :locations, through: :user_locations
    has_many :photos
    has_many :comments
    has_many :posts

    before_save { email.downcase! }
    validates :user_name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
