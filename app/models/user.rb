class User < ActiveRecord::Base
  has_secure_password

  before_save :normalize_email

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    user.authenticate(password) ? user : nil;
  end

  def normalize_email
    self.email = self.email.downcase.strip
  end
end