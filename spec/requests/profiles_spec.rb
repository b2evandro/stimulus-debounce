require 'rails_helper'

RSpec.describe "ProfilesController", type: :request do
  describe "GET #index" do
    let(:github_service) { instance_double(GithubService) }
    let(:user_data) { { "id" => 123, "login" => "example" } }

    before do
      allow(GithubService).to receive(:new).and_return(github_service)
    end

    context "when the username parameter is present" do
      before do
        allow(github_service).to receive(:search_user).with("example").and_return(user_data)
      end

      context "when the request is a Turbo Frame request with id 'search'" do
        before do
          get "/profiles", params: { username: "example" }, headers: { 'Turbo-Frame': 'search' }
        end

        it "instantiates GithubService" do
          expect(GithubService).to have_received(:new)
        end

        it "calls GithubService#search_user with the given username" do
          expect(github_service).to have_received(:search_user).with("example")
        end

        it "responds with success" do
          expect(response).to be_successful
        end

        it "renders the user_data partial" do
          expect(request.headers['Turbo-Frame']).to eq('search')
          expect(response).not_to render_template(:index)

          expect(response).to render_template(partial: "user_data", locals: { user_data: user_data })
        end
      end

      context "when the request is not a Turbo Frame request with id 'search'" do
        before do
          get "/profiles", params: { username: "example" }, headers: { 'Turbo-Frame': 'another_id' }
        end

        it "instantiates GithubService" do
          expect(GithubService).to have_received(:new)
        end

        it "calls GithubService#search_user with the given username" do
          expect(github_service).to have_received(:search_user).with("example")
        end

        it "responds with success" do
          expect(response).to be_successful
        end

        it "renders the default HTML template" do
          expect(request.headers['Turbo-Frame']).to eq('another_id')
          expect(response).to render_template(:index)
        end
      end
    end

    context "when the username parameter is absent" do
      before do
        get "/profiles"
      end

      it "responds with success" do
        expect(response).to be_successful
      end

      it "renders the default HTML template" do
        expect(response).to render_template(:index)
      end
    end

    context "when the user does not exist" do
      before do
        allow(github_service).to receive(:search_user).and_return(nil)
        get "/profiles", params: { username: "nonexistentuser" }
      end

      it "instantiates GithubService" do
        expect(GithubService).to have_received(:new)
      end

      it "calls GithubService#search_user with the given username" do
        expect(github_service).to have_received(:search_user).with("nonexistentuser")
      end

      it "responds with success" do
        expect(response).to be_successful
      end

      it "renders the 'user_not_found' partial" do
        expect(response).to render_template(:index)
      end
    end
  end
end