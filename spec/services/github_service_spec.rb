require 'rails_helper'
RSpec.describe GithubService do
  let(:service) { described_class.new }
  let(:login) { 'example' }
  
  describe '#initialize' do
    it 'creates a new Faraday connection' do
      expect(service.instance_variable_get(:@conn)).to be_a(Faraday::Connection)
    end
  end
  
  describe '#search_user' do
    context 'when the user exists' do
      let(:response_body) { { 'id' => 123, 'login' => login }.to_json }

      before do
        stub_request(:get, "https://api.github.com/users/#{login}")
          .to_return(status: 200, body: response_body)
      end

      it 'sends a GET request to the correct endpoint' do
        service.search_user(login)
        expect(WebMock).to have_requested(:get, "https://api.github.com/users/#{login}")
      end

      it 'returns the user data as a hash' do
        expect(service.search_user(login)).to eq(JSON.parse(response_body))
      end
    end

    context 'when the user does not exist' do
      before do
        stub_request(:get, "https://api.github.com/users/#{login}")
          .to_return(status: 404, body: '')
      end

      it 'sends a GET request to the correct endpoint' do
        service.search_user(login)
        expect(WebMock).to have_requested(:get, "https://api.github.com/users/#{login}")
      end

      it 'returns nil' do
        expect(service.search_user(login)).to be_nil
      end
    end
  end
end
