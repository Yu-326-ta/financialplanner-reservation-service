require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get ""
      expect(response).to have_http_status :ok
    end
  end
end
