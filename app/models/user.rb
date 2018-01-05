class User < ApplicationRecord
  has_many :relationships, dependent: :destroy
  has_many :friends, through: :relationships
  has_many :tickets
  has_many :events, through: :tickets
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validates :email, presence: true


  def friends
    self.relationships.map { |r| r.friend }
  end


  def add_friend(friend)
    [Relationship.create(user_id: self.id, friend_id: friend.id),
    Relationship.create(friend_id: self.id, user_id: friend.id)]
  end


  def buy_ticket(event)
    Ticket.create(user: self, event: event, price: event.price_min)
  end

  
end
