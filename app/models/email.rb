class Email < ApplicationRecord
  has_many :mailings
  has_many :profiles, through: :mailings

  validates :subject, presence: true, allow_blank: false,  on: :update
  validates :body, presence: true, allow_blank: false,  on: :update
  validates :title, presence:true, allow_blank: false,  on: :update
  validates :tag, presence:true, allow_blank: false,  on: :update
end
