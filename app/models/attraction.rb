class Attraction < ApplicationRecord
  has_many :attraction_events
  has_many :events, through: :attraction_events
  accepts_nested_attributes_for :events

  def event_attributes=(event_attributes)
    event_attributes.each do |event_attribute|
      event = Event.find_or_create_by(event_attriubte)
      self.events << event
    end
  end 



end
