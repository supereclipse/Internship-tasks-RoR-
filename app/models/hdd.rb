class Hdd < ApplicationRecord
  belongs_to :vm, dependent: :destroy
end
