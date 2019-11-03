require "rails_helper"

RSpec.describe Article, type: :model do
  context "正常系" do
    let(:article) { build(:article) }

    it "記事の作成・保存完了" do
      expect(article).to be_valid
    end
  end

  context "titleがないとき" do
    let(:article) { build(:article, title: nil) }

    it "エラーする" do
      article.valid?
      expect(article.errors.messages[:title]).to include "can't be blank"
    end
  end

  context "titleが長すぎるとき" do
    let(:article) { build(:article, title: Faker::Lorem.characters(number: Random.new.rand(65..999)))}

    it "エラーする" do
      article.valid?
      expect(article.errors.messages[:title]).to include "is too long (maximum is 64 characters)"
    end
  end
end
