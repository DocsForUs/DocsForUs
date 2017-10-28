require 'rails_helper'

RSpec.describe BetterDoctorsController, type: :controller do
  describe "methods" do
    it 'searches api for doctors with matching first and last name'
    it 'returns multiple doctors if there are mutliple doctors with that name'
    it 'returns no doctors if they are not in the better doctors api'
  end
end
