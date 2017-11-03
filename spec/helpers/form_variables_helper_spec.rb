require 'rails_helper'

RSpec.describe FormVariablesHelper, type: :helper do
  it 'assigns the insurance variable' do
    data = form_data
    expect(data).to include(:genders, :insurance, :specialties)
  end
end
