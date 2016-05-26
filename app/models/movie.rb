class Movie < ActiveRecord::Base

  has_many :reviews
  belongs_to :user
  scope :title_search, ->(title_q) {where("title like :kw", :kw=>"%#{title_q}%")}
  scope :director_search, ->(director_q) {where("director like :kw", :kw=>"%#{director_q}%")}
  scope :runtime_search_less, ->(runtime) {where("runtime_in_minutes < ?", runtime)}
  scope :runtime_search_between, ->(runtime_one, runtime_two) {where("runtime_in_minutes > :runtime_one AND runtime_in_minutes < :runtime_two", {runtime_one: runtime_one, runtime_two: runtime_two})}
  scope :runtime_search_greater, ->(runtime) {where("runtime_in_minutes >= ?", runtime)}
  scope :single_search, ->(query) {where("title like :kw or director like :kw", :kw=>"%#{query}%")}
  mount_uploader :poster_image_url, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
