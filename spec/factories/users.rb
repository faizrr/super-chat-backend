FactoryGirl.define do
  factory :user do
    name FFaker::Name.name
    sequence :auth0_id do |n|
      "auth_method|#{n}"
    end
  end
end
