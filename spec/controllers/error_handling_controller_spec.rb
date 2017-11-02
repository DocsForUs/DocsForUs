require 'rails_helper'

describe UsersController, type: :controller do
  it "returns a not found response" do
    get :show, { id: 'not_existing_page_321' }
    expect(response.status).to eq(404)
    expect(response.text).to match(/Page page_not_found doesn't exist/)
end
end
