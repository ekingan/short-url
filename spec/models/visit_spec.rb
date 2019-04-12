require 'rails_helper'

describe Visit do
  let!(:visit) { create(:visit) }

  it { should validate_presence_of(:link_id) }
end
