class Location < ApplicationRecord
    has_many :user_location
    has_many :users, through: :user_location
    has_many :light_pollutions
    has_many :weathers
    has_many :posts, dependent: :destroy
    has_many :photos, dependent: :destroy
    has_one_attached :image
end
