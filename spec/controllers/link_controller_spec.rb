require 'rails_helper'

describe LinkController do
  let!(:link) { create(:link, :with_visits) }

  def json_response 
    JSON.parse(response.body)
  end

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
      expect(json_response['slug']).to eq 'my-custom-url'
      expect(json_response['full_link']).to eq 'http://test.host/my-custom-url'
    end
  end

  describe 'GET #show' do
    it 'redirects short links to the original url' do
      get 'show', params: { slug: link.slug }
      expect(response).to redirect_to link.body
    end
  end

  describe 'GET #stats' do
    before { post :index, params: { slug: link.slug }}

    it 'provides the date the link was created' do
      expect(json_response['created_at']).to be_present
    end

    it 'provides the total visits to that link' do
      expect(json_response['total_visits']).to be_present
      expect(json_response['total_visits']).to eq 20
    end

    it 'provides a hash of visits per day' do
      expect(json_response['visits_per_day']).to be_present
    end
  end
end
