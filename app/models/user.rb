class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :nav
         
  validates_uniqueness_of :nickname
  
  before_save do
    self.nickname.downcase! if self.nickname
  end
end
