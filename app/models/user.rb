class User < ActiveRecord::Base
  has_many :questions, dependent: :nullify
  has_many :answers,   dependent: :nullify

  has_many :likes, dependent: :destroy
  
  has_many :liked_questions, through: :likes, source: :question

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name_display
    if first_name || last_name
      "#{first_name} #{last_name}".strip.squeeze(" ")
    else
      email
    end
  end
end
