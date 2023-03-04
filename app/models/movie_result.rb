class MovieResult < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
