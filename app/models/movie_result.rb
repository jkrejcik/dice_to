class MovieResult < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_one :review
end
