require 'rails_helper'

describe LinkController do
  let!(:link) { create(:link) }

  describe 'POST #create' do
    let(:valid_attributes) { 
      { body: Faker::Internet.url, base_url: 'http://www.localhost:3000' }
    }

    before { post :create, params: valid_attributes }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns a json object with the original link' do
      expect(response.body['original_link']).to be_present
    end

    it 'returns a json object with the short slug' do
      expect(response.body['slug']).to be_present
    end

    it 'returns a json object with the full shortened link' do
      expect(response.body['full_link']).to be_present
    end

    it 'when given the same original link returns the same shortened URL' do
      shortened = response.body['slug']
      post :create, params: valid_attributes
      expect(response.body['slug']).to eq shortened
    end

  end

  describe 'GET #show' do
    it 'redirects short links to the original url' do
      get 'show', params: { slug: link.slug }
      expect(response).to redirect_to link.body
    end
  end
end
