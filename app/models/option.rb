class Option < ApplicationRecord
  belongs_to :custom_result

  validates :input, presence: true
end
