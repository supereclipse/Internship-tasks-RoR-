class Report < ApplicationRecord
  enum reptype: %w[expensive cheap most_capacity_of_type e_volume_amount e_volume_volume]
  validates :depth, numericality: { greater_than: 0 }
end
