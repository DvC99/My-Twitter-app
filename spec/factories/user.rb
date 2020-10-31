FactoryBot.define do
    factory :user do
      sequence(:id) {|n|}
      sequence(:email){|n| "user_#{n}@uninorte.edu.co"}
      sequence(:username){|n| "user_#{n}"}
      sequence(:password){|n| "encrypted_password_#{n}"}      
      created_at { Time.now }
      updated_at { Time.now }
      confirmed_at { Time.now }
    end
  end
  