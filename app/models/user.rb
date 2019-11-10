class User < ApplicationRecord
  has_secure_password
  has_many :user_beer

  def to_token
    {
        id: self.id,
        name: self.name,
        username: self.username,
    }
  end
end
