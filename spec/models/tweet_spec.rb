require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:twittear) }
  end
 ## Seria de esta forma pero como no tenemos una asociacion entre las tablas Tweet y User, esto no es necesario
 # describe 'associations' do
 #   it { should belong_to(:user) }
 # end
end
