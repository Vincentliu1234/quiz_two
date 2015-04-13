class Question < ActiveRecord::Base


  
  has_many :answers, dependent: :destroy

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  belongs_to :user

  validates :title, presence:   {message: "must be provided."}, 
                    uniqueness: {case_sensitive: false},
                    length:     {minimum: 10}

  validates :body, presence: true

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  validate :stop_words

  
  after_initialize :set_defaults

  scope :recent, lambda { order("updated_at DESC") }
 

  scope :recent_ten, lambda { recent.limit(10) }

 
  scope :most_recent, lambda { |n| recent.limit(n)  }
  
  scope :last_three_days, lambda { where("created_at >= ?", 3.days.ago) }

  
  scope :last_ten_days, lambda { where(created_at: 
                                  (Time.now - 10.days)..(Time.now)) }

  
  def self.days_ago(n)
    where("created_at >= ?", n.days.ago)
  end


 
  before_save :capitalize_title

 

  def self.search(search_term)
    Question.where("title ILIKE ? OR body ILIKE  ?", 
                        "%#{search_term}%", "%#{search_term}%")
  end

  def increment_view_count
    
    increment!(:view_count)
  end

  private

  def set_defaults
    self.view_count ||= 0
  end

  def capitalize_title
    self.title.capitalize!
  end

  def stop_words
    if title.present? && title.include?("*")
    

      errors.add(:base, "Please don't put * in title")
    end
  end

end


