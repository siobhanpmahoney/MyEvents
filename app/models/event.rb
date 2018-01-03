class Event < ApplicationRecord
  belongs_to :attraction
  belongs_to :venue
end
