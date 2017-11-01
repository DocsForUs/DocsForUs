require 'rails_helper'

RSpec.describe TagTitleHelper, type: :helper do

  it 'returns a hash of tag category titles' do
    expect(tag_title[:safe]).to eq "I felt safe with this doctor as a person who identifies as..."
  end
  
end
