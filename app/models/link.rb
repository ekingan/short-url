class Link < ApplicationRecord
  validates :body, presence: true
  validates :body, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'Valid URL required' }
  validates :slug, uniqueness: true

  before_create :generate_slug, :generate_full_link
 
  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(6) unless self.slug.present?
  end

  def generate_full_link
    self.full_link = "#{base_url}/#{slug}"
  end
end
