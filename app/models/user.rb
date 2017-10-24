class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  before_save { :password == password_confirmation }
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: {minimum: 8 }
  include ActiveModel::Validations
  # validates_with DocumentValidator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_one :users, foreign_key: 'invitee'
  
  has_many :sent_shipments, class_name: 'Shipment', foreign_key: 'sender_id'
  has_many :received_shipments, class_name: 'Shipment', foreign_key: 'receiver_id'
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
   def forget
    update_attribute(:remember_digest, nil)
  end
end
