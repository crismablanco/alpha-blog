class Article < ApplicationRecord
  validates :title, presence: true, length: { minumum: 3, maximum: 50}
  validates :description, presence: true, length: { minumum: 10, maximum: 1000 }
end