class Photo < ApplicationRecord
    belongs_to :user
    belongs_to :post
    belongs_to :location
end
