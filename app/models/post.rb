class Post < ApplicationRecord
    belongs_to :user
    belongs_to :location
    has_many :photos
    has_many :comments
end
