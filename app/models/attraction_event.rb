class AttractionEvent < ApplicationRecord
  belongs_to :event
  belongs_to :attraction
end
