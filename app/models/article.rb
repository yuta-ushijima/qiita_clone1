class Article < ApplicationRecord
  belongs_to :user
  has_many :comment, dependent: :destroy
  has_many :article_like, dependent: :destroy
end
