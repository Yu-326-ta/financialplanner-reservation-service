require 'rails_helper'

RSpec.describe "ClientsSessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get clients_login_path
      expect(response).to have_http_status(:success)
    end
  end

end
