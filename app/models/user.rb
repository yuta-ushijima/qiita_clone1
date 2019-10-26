# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {in: 8..32}

  has_many :articles, dependent: :destroy
  has_many :article_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
