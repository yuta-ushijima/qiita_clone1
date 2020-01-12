require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "正しい情報が送られたとき" do
      let(:params) { attributes_for(:user) }
      it "ユーザー登録ができる" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "アカウント名が空のとき" do
      let(:params) { attributes_for(:user, name: nil) }

      it "ユーザー登録できない" do
        subject
        expect { subject }.to change { User.count }.by(0)
      end
    end

    context "emailが空のとき" do
      let(:params) { attributes_for(:user, email: nil) }

      it "ユーザー登録できない" do
        subject
        expect { subject }.to change { User.count }.by(0)
      end
    end

    context "passwordが空のとき" do
      let(:params) { attributes_for(:user, password: nil) }

      it "ユーザー登録ができない" do
        subject
        expect { subject }.to change { User.count }.by(0)
      end
    end
  end

  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    context "登録されている正しい情報が送られたとき" do
      let!(:user) { create(:user) }
      let(:params) { { email: user.email, password: user.password } }

      it "ログインできる" do
        subject
        expect(response).to have_http_status(:ok)

        res = response.headers
        expect(headers["access-token"]).to be_present
        expect(headers["client"]).to be_present
        expect(headers["uid"]).to be_present
      end
    end

    context "パスワードが間違っているとき" do
      let!(:user) { create(:user) }
      let(:params) { { email: user.email, password: Faker::Movies::HarryPotter.quote } }

      it "ログインできない" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "登録されていないemailを送信したとき" do
      let!(:user) { create(:user) }
      let(:params) { { email: Faker::Movies::HarryPotter.quote, password: user.password } }

      it "ログインできない" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    context "正しいheaders を渡したとき"
    let!(:headers) { authenticate_user_headers(user) }
    let(:user) { create(:user) }

    it "ログアウトできる" do
      subject
      expect(user.reload.tokens).to be_blank
      expect(response).to have_http_status(:ok)
    end
  end
end
