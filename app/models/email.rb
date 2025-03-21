class Email < ApplicationRecord
  has_many :mailings
  has_many :profiles, through: :mailings

  validates :subject, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
end
