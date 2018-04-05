class User < ApplicationRecord
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, :session_token, :password_digest, presence: true
  validates :username, uniqueness: true

  after_initialize :ensure_session_token

  has_many :photos,
    class_name: :Photo,
    foreign_key: :author_id


  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
