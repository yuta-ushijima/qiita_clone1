class Api::V1::Current::ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at

  belongs_to :user
end
