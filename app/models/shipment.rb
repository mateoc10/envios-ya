class Shipment < ApplicationRecord
    
    has_one :users, foreign_key: 'sender'
	has_one :users, foreign_key: 'receiver'
	has_one :locations, foreign_key: 'origin'
	has_one :locations, foreign_key: 'destination'
	has_one :drivers, foreign_key: 'driver'
    
end
