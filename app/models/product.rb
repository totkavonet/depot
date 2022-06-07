class Product < ApplicationRecord
  validates :title, uniqueness: true, length: { in: 10..20, message: 'can not be blank and should be greater then 10 and less then 20' }
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

end
