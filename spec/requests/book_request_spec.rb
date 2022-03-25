require 'rails_helper'

RSpec.describe "Books", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/book/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/book/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/book/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
