class User < ApplicationRecord
  has_many :relationships, dependent: :destroy
  has_many :friends, through: :relationships
  has_secure_password

  def friends


  end


  def add_friend(friend)
    [Relationship.create(user_id: self.id, friend_id: friend.id),
    Relationship.create(friend_id: self.id, user_id: friend.id)]
  end

  # validates :username, presence: true, uniqueness: true
  # validates :password, presence: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :birth_date, presence: true
  # validates :email, presence: true

end
