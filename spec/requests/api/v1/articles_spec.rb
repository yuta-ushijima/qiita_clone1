require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /api/v1/articles" do
    subject {get(api_v1_articles_path)}

    before do
      create_list(:article, 3)
    end


    it "記事の一覧が取得できる" do
      #get api_v1_articles_path
      subject
      res = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(res.length).to eq Article.count
      expect(res[0].keys).to eq ["id", "title", "body"]
    end
  end
end
