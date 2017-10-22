class Location < ApplicationRecord
  has_one :shipment
  has_one :driver
  has_one :shipment
end
