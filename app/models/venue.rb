class Venue < ApplicationRecord
  has_many :events

  def event_attributes=(event_attributes)
    event_attributes.each do |event_attribute|
      event = Event.find_or_create_by(event_attriubte)
      self.events << event
    end
  end 
end
