FactoryGirl.define do
  factory :post do
    author
    title     { FFaker::Job.title }
    body      { FFaker::HipsterIpsum.phrase }
    published { true }

    after :create do |post|
      create_list(:post_tag, 3, post: post)
    end
  end
end
