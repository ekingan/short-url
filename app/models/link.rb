class Link < ApplicationRecord
  validates_presence_of :body
  validates :body, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'Valid URL required' }
  validates_uniqueness_of :full_link, message: 'This URL is already taken, please choose a different one'

  before_create :generate_full_link

  def generate_full_link
    self.full_link = "#{base_url}/#{slug}"
  end
end
