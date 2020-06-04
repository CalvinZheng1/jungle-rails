class User < ActiveRecord::Base
  has_secure_password

  validates :name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { without: /\s/, message: "must contain no spaces" }
  validates :password, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      @user = user
    else
      @user = nil
    end
  end

end