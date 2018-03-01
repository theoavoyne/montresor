class Product < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :offers, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true
  validates :category, presence: true
  validates :description, length: { maximum: 500, message: "should be less than 500 characters" }
  validates :price, presence: true, numericality: { less_than_or_equal_to: 99999 }
end
