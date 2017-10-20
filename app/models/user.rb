class User < ApplicationRecord
  before_save { email.downcase! }
  before_save { :password == password_confirmation }
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: {minimum: 8 }
  include ActiveModel::Validations
  validates_with DocumentValidator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_one :users, foreign_key: 'invitee'
end
