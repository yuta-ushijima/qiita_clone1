require "rails_helper"

RSpec.describe "Api::V1::Current::Articles", type: :request do
  describe "GET /api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers: headers) }

    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:headers) { authenticate_user_headers(current_user) }

    let!(:article1) { create(:article, :draft, user: current_user) }
    let!(:article2) { create(:article, :published, user: current_user, updated_at: 1.hour.ago) }
    let!(:article3) { create(:article, :published, user: current_user, updated_at: 2.hour.ago) }
    let!(:article4) { create(:article, :draft, user: other_user) }
    let!(:article5) { create(:article, :published, user: current_user, updated_at: 1.day.ago) }

    it "自分の公開記事を一覧として取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(res.length).to eq current_user.articles.published.count
      expect(res.map{ |s| s["id"]}).to eq [article2.id, article3.id, article5.id]
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["title"]).to eq article2[:title]
      expect(res[0]["id"]).to eq article2[:id]
    end
  end
end