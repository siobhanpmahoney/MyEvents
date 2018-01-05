class Event < ApplicationRecord
  has_many :attraction_events
  has_many :attractions, through: :attraction_events
  has_many :category_events
  has_many :categories, through: :category_events

  belongs_to :venue
  accepts_nested_attributes_for :attractions
  accepts_nested_attributes_for :categories

  def attraction_attributes=(attraction_attributes)
    attraction_attributes.each do |attraction_attribute|
      attraction = Attraction.find_or_create_by(attraction_attribute)
      self.attractions << attraction
    end
  end

  def category_attributes=(category_attributes)
    category_attributes.each do |category_attribute|
      category = Event.find_or_create_by(category_attriubte)
      self.categories << category
    end
  end
end
