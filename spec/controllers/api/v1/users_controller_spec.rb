require "spec_helper"

RSpec.describe Api::V1::UsersController do
  describe "POST create" do
    it "creates @user" do  
      post :create, user: { email: "qwe@gmail.com", password: "123123qwe" }
      expect(response.status).to eq(201)
    end
  end

  describe "POST create" do
    it "should not creates @user, no password" do  
      post :create, user: { email: "qwe@gmail.com" }
      expect(response.status).to eq(422)
    end
  end
end
