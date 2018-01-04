class Category < ApplicationRecord
  has_many :category_events
  has_many :events, through: :category_events
  accepts_nested_attributes_for :events

  def event_attributes=(event_attributes)
    event_attributes.each do |event_attribute|
      event = Event.find_or_create_by(event_attriubte)
      self.events << event
    end
  end
end
