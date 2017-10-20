class Location < ApplicationRecord
  belongs_to :driver
  belongs_to :shipment
  belongs_to :shipment
end
