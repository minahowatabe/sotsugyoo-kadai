class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        # ,:confirmable

  has_many :plans, dependent: :destroy 
  has_many :favorites, dependent: :destroy
  has_many :favorite_plans, through: :favorites, source: :plan
  
end
