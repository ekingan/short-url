require 'rails_helper'

describe Link do
  let!(:link) { create(:link) }

  it { should validate_presence_of(:body) }

end
