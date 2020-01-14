require "rails_helper"

RSpec.describe "Api::V1::Articles::Drafts", type: :request do
  describe "GET /api/v1/articles/drafts" do
    subject { get(api_v1_articles_drafts_path, headers: headers) }

    before do
      create_list(:article, 20, :draft, user: current_user)
      create_list(:article, 20, :published, user: current_user)
      create_list(:article, 35, :draft, user: other_user)
      create_list(:article, 35, :published, user: other_user)
    end

    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:headers) { authenticate_user_headers(current_user) }
    let(:other_user_id) { other_user.id }

    it "自分の下書き記事のみ一覧になる" do
      subject
      res = JSON.parse(response.body)
      len = res.length
      expect(response).to have_http_status(:ok)
      expect(res.length).to eq current_user.articles.draft.count
      expect(res[0].keys).to eq ["id", "title", "body", "updated_at", "status", "user"]

      # 本当はメソッドとして定義したい
      i = 0
      ary_status = Array.new(len)
      count_user = 0

      while i < len
        ary_status[i] = res[i]["status"]

        if res[i]["user"]["id"] != current_user.id
          count_user += 1
        end
        i += 1
      end

      # 下書き記事のみ取得している
      expect(ary_status.include?("published")).to eq false
      # 自分の記事のみ取得している
      expect(count_user).to eq 0
      binding.pry
    end
  end

  describe "GET /api/v1/articles/drafts/:id" do
    subject { get(api_v1_articles_draft_path(article_id), headers: headers) }

    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:headers) { authenticate_user_headers(current_user) }

    context "自分の下書き状態の記事を指定したとき" do
      let(:article) { create(:article, :draft, user: current_user) }
      let(:article_id) { article.id }

      it "記事の詳細を表示できる" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present
      end
    end

    context "自分の公開記事を指定したとき" do
      let(:article) { create(:article, :published, user: current_user) }
      let(:article_id) { article.id }

      it "表示できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "他のユーザーの記事を指定したとき" do
      let(:article) { create(:article, user: other_user) }
      let(:article_id) { article.id }

      it "表示できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
