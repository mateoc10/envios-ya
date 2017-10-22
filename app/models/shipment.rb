class Shipment < ApplicationRecord
    belongs_to :receiver, class_name: 'User'
	belongs_to :sender, class_name: 'User'
	belongs_to :origin, class_name: 'Location'
	belongs_to :destination, class_name: 'Location'
	belongs_to :driver
end
