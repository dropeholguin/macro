class AcceptedPrivacy < ApplicationRecord
  belongs_to :user
  belongs_to :privacy
end
