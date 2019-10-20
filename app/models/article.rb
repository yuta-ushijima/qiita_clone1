class Article < ApplicationRecord
  belongs_to :user
  has_many :comment
  has_many :article_like
end
