class User < ApplicationRecord

  scope :name_length, -> { where('LENGTH(first_name) > 5 AND LENGTH(last_name) < 6') }

  has_many :orders
  has_one :passport_data
end
