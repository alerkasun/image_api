require "spec_helper"

RSpec.describe Api::V1::UsersController do
  describe "POST create" do
    it "response status 201" do
        post :create, user: { email: 'email@gmail.com', password: '12345678', password_confirmation: '12345678' }
        expect(response.status).to eq(201)
      end

    # it "check email in json" do
    #   post :create, user: { email: 'email@gmail.com', password: '12345678' }
    #   expect(json_response["email"]).to eq('email@gmail.com')
    # end

  #   it "check token in response" do
  #     post :create, user: { email: 'email@gmail.com', password: '12345678' }
  #     expect(response['HTTP_API_TOKEN']).to match(/^Token\s+[-\w]+$/)
  #   end
  end

  describe "POST create" do
    it "should not creates @user, no password" do  
      post :create, user: { email: "qwe@gmail.com" }
      expect(response.status).to eq(422)
    end

      it "response status 201" do
        post :create, user: { email: 'email@gmail.com', password: '12345678' }
        expect(response.status).to eq(201)
      end
  end
end
