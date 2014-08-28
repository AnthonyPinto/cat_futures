class User < ActiveRecord::Base
  attr_reader :password
  
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: { message: "Password can't be blank" }
  # before_validation 
  
  
  has_many(
    :cats,
    class_name: 'Cat',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :cat_rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  
  
  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)
    (user && user.is_password?(password)) ? user : nil
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.base64
    self.save!
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_session_token
    # self.reset_session_token!
  end
  
end
