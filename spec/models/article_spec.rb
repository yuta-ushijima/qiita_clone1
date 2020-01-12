require "rails_helper"

RSpec.describe Article, type: :model do
  context "正常系(statusの指定がないとき)" do
    let(:article) { build(:article) }

    it "下書きとして記事が有効である" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
      expect { article.save! }.to change { Article.draft.count }.by(1)
    end
  end

  context "正常系（statusがpublishedのとき）" do
    let(:article) { build(:article, status: "published") }

    it "公開記事として有効である" do
      expect(article).to be_valid
      expect(article.status).to eq "published"
      expect { article.save! }.to change { Article.published.count }.by(1)
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

describe "#draft" do
  before do
    create_list(:article, 10)
  end

  it "draftの検索ができる" do
    expect(Article.draft).to eq Article.where(status: "draft")
  end
end

describe "#published" do
  before do
    create_list(:article, 10 ,:published)
  end

  it "publishedの検索ができる" do
    expect(Article.published).to eq Article.where(status: "published")
  end
end



describe "#.status" do
  context "statusがdraftのとき" do
    let(:article) { create(:article, :draft) }

    it "draftが返ってくる" do
      expect(article.status).to eq "draft"
    end
  end

  context "statusがpublishedのとき" do
    let(:article) { create(:article, :published) }

    it "publishedが返ってくる" do
      expect(article.status).to eq "published"
    end
  end
end

describe "#.draft?" do
  context "statusがdraftのとき" do
    let(:article) { create(:article, :draft) }

    it "trueが返ってくる" do
      expect(article.draft?).to eq true
    end
  end

  context "statusがpublishedのとき" do
    let(:article) { create(:article, :published) }

    it "false" do
      expect(article.draft?).to eq false
    end
  end
end

describe "#.published?" do
  context "draftのとき" do
    let(:article) { create(:article, :draft) }

    it "false" do
      expect(article.published?).to eq false
    end
  end

  context "publishedのとき" do
      let(:article) { create(:article, :published) }

      it "true" do
        expect(article.published?).to eq true
      end
  end
end

describe "#.published!" do
  context "draftのとき" do
    let(:article) { create(:article, :draft) }

    it "publishedに更新される" do
      expect(article.published!).to eq true
      expect(article[:status]).to eq "published"
    end
  end
end

describe "#.draft!" do
  context "publishedのとき" do
    let(:article) { create(:article, :published) }

    it "draftに更新する" do
      expect(article.draft!).to eq true
      expect(article[:status]).to eq "draft"
    end
  end
end
