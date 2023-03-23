class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :planner
end
