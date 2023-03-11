class CustomResult < ApplicationRecord
  belongs_to :user
  has_many :options
  accepts_nested_attributes_for :options
end
