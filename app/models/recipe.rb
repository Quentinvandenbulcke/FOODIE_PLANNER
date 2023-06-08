class Recipe < ApplicationRecord
  has_many :meal_days
  has_many :ingredients
  has_many :favorites
  has_one_attached :photo
  validates :name, :description, presence: true
  validates :prep_time, :rating, :servings, presence: true, numericality: { only_integer: true, greater_than: 0 }

  include PgSearch::Model

  pg_search_scope :search_by_name_desc_cat,
                  against: %I[name description category],
                  using: { tsearch: { prefix: true } }
end
