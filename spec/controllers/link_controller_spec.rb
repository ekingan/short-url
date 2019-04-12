require 'rails_helper'

describe LinkController do
  let!(:link) { create(:link) }

  describe 'POST #create' do
    let(:valid_attributes) { 
      { body: Faker::Internet.url }
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

  describe 'POST #custom' do
    it 'creates a custom url' do
      post :custom, 
        params: 
        { 
          body: Faker::Internet.url, 
          slug: 'my-custom-url'
        }
      expect(JSON.parse(response.body)['slug']).to eq 'my-custom-url'
      expect(JSON.parse(response.body)['full_link']).to eq 'http://test.host/my-custom-url'
    end
  end

  describe 'GET #show' do
    it 'redirects short links to the original url' do
      get 'show', params: { slug: link.slug }
      expect(response).to redirect_to link.body
    end
  end
end
