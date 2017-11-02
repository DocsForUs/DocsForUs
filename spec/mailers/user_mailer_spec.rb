require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome_email' do
    let!(:user) { create(:user) }
    let!(:mail) { UserMailer.welcome_email(user) }
    it 'sends email to correct user' do
      expect(mail.to).to eq ["llama@llama.com"]
    end
    it 'sends email from correct email' do
      expect(mail.from[0]).to end_with "@gmail.com"
    end
    it 'sends email with correct subject' do
      expect(mail.subject).to eq 'Welcome to DocsForUs'
    end
  end
end
