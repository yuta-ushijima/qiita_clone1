require "rails_helper"

RSpec.describe Article, type: :model do
  context "正常系(statusの指定がないとき)" do
    let(:article) { build(:article) }

    it "下書きとして記事が有効である" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
      expect { article.save! }.to change { Article.where(status: "draft").count }.by(1)
    end
  end

  context "正常系（statusがpubrishedのとき）" do
    let(:article) { build(:article, status: "published") }

    it "公開記事として有効である" do
      expect(article).to be_valid
      expect(article.status).to eq "published"
      expect { article.save! }.to change { Article.where(status: "published").count }.by(1)
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
    let(:article) { build(:article, title: Faker::Lorem.characters(number: Random.new.rand(65..999))) }

    it "エラーする" do
      article.valid?
      expect(article.errors.messages[:title]).to include "is too long (maximum is 64 characters)"
    end
  end
end
