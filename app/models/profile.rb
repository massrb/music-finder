class Profile < ApplicationRecord
  has_many :mailings
  has_many :emails, through: :mailings
	has_one_attached :image
  include Parseable

  def thumbnail
    image.variant(resize_to_limit: [200, 200]).processed
  end
end
