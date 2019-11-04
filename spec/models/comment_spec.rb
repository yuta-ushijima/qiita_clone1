require "rails_helper"

RSpec.describe Comment, type: :model do
  context "コメントがあるとき" do
    #let(:user) { build(:user) }
    #let(:article) { build(:article) }
    let(:comment) { build(:comment) }
    it "コメントが有効である" do
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
