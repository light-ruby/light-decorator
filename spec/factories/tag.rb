FactoryGirl.define do
  factory :tag do
    name { FFaker::Job.title }
  end
end
