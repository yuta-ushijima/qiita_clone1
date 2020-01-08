class Article < ApplicationRecord
  enum status: {
    draft: "draft", published: "published"
  }

  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: { maximum: 64 }
  validates :body, presence: true

  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy
end
