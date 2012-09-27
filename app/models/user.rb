class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me , :login
  # attr_accessible :title, :body


  validates :login,
            :presence => true,
            :uniqueness => true,
            :length => { :minimum => 4, :maximum => 20 }

  validates_format_of :login, with: /\A[a-z0-9-]+\z/i # Letters, numbers, dashes

  # Overrides the devise method find_for_authentication
  # Allow users to Sign In using their username or email address
  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["login = :value OR email = :value", { :value => login }]).first
  end


end
