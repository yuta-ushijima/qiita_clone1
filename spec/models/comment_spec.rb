require "rails_helper"

RSpec.describe Comment, type: :model do
  context "コメントがあるとき" do
    let(:article) { build(:article) }
    let(:comment) { build(:comment, article: article) }
    it "コメントの保存完了" do
      expect(comment).to be_valid
    end
  end

  context "コメントがないとき" do
    let(:article) { build(:article) }
    let(:comment) { build(:comment, body: nil, article: article) }

    it "エラーする" do
      comment.valid?
      expect(comment.errors.messages[:body]).to include "can't be blank"
    end
  end
end
