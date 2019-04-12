require 'rails_helper'

describe Link do
  let!(:link) { create(:link) }

  it { should validate_presence_of(:body) }
  it { should validate_uniqueness_of(:slug) }

  it 'generates an 8 character random slug given a url' do
    expect(link.slug).to be_present
    expect(link.slug.length).to eq 8
  end

  it 'generates a shortened link provided a url' do
    expect(link.full_link).to be_present
    expect(link.full_link).to eq "#{link.base_url}/#{link.slug}"
  end

  it 'does not generate a random slug if there is a custom slug present' do
    custom_link = create(:link, slug: 'my-custom-link')
    custom_link.save!
    expect(link.full_link).to eq "#{custom_link.base_url}/my-custom-link"
  end
end
