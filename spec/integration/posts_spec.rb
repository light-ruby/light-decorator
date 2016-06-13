require 'spec_helper'

RSpec.describe 'GET /posts/:id' do
  let(:post) { create(:post) }

  it 'check title h1' do
    visit "/posts/#{post.id}"
    expect(page.find('.post-header h1')).to have_content(post.title)
  end

  it 'check author full name' do
    visit "/posts/#{post.id}"
    expect(page).to have_content("#{post.author.first_name} #{post.author.last_name}")
  end
end
