class Order < ApplicationRecord
  # validates :name, presence: true
  # validates_with NameValidator
  # validates_with UserValidator
  enum status: {unavailable: 0, created: 1, started: 2, failed: 3, removed: 4}
  belongs_to :user
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :networks
end
