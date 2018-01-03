class Event < ApplicationRecord
  has_many :attraction_events
  has_many :attractions, through: :attraction_events

  belongs_to :venue
  accepts_nested_attributes_for :attractions

  def attraction_attributes=(attraction_attributes)
    attraction_attributes.each do |attraction_attribute|
      attraction = Attraction.find_or_create_by(attraction_attribute)
      self.attractions << attraction
    end
  end
end
