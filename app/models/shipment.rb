class Shipment < ApplicationRecord
    belongs_to :receiver, class_name: 'User'
	belongs_to :sender, class_name: 'User'
	# has_one :origin, class_name: 'Location'
	# has_one :destination, class_name: 'Location'
	has_one :driver
end
