require 'rails_helper'

RSpec.describe "Pages", type: :request do

  describe "GET /products" do
    it "returns http success" do
      get "/pages/products"
      expect(response).to have_http_status(:success)
    end
  end

end
