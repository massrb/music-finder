class Mailing < ApplicationRecord
  belongs_to :email
  belongs_to :profile
end
