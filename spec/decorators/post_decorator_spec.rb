require 'spec_helper'

RSpec.describe PostDecorator do
  let(:post)           { create(:post) }
  let(:decorated_post) { post.decorate }

  it 'decorator exist' do
    expect { PostDecorator }.to_not raise_error
  end

  it 'decorate post' do
    expect(post).to_not be_decorated
    expect(post.decorate).to be_decorated
  end

  it 'decorate post via method' do
    expect(post).to_not be_decorated
    expect(post.decorate).to be_decorated
  end

  it 'decorate post via class' do
    expect(post).to_not be_decorated

    expect(PostDecorator.new(post)).to be_decorated
    expect(PostDecorator.decorate(post)).to be_decorated
  end

  it 'title h1 method' do
    expect(decorated_post.title_h1).to eql("<h1>#{post.title}</h1>".html_safe)
  end

  it 'h alias of helpers' do
    expect(decorated_post.title_h1_h).to eql("<h1>#{post.title}</h1>".html_safe)
  end

  it 'o alias of object' do
    expect(decorated_post.title_o).to eql(post.title)
  end

  it 'decorate belongs to association' do
    expect(decorated_post.author).to be_decorated
  end

  it 'decorate has many through association' do
    expect(decorated_post.tags.take).to be_decorated

    decorated_post.tags.each do |tag|
      expect(tag).to be_decorated
    end

    decorated_post.tags.where.not(id: nil).each do |tag|
      expect(tag).to be_decorated
    end

    decorated_post.tags.limit(2).each do |tag|
      expect(tag).to be_decorated
    end
  end

  it 'find and decorate' do
    expect(Post.find_and_decorate(post.id)).to be_decorated
  end

  it '==' do
    expect(decorated_post == post).to be(true)
    expect(post == decorated_post).to be(true)

    # rubocop:disable Lint/UselessComparison
    expect(decorated_post == decorated_post).to be(true)
  end

  it 'eql' do
    expect(decorated_post.eql?(post)).to be(true)
    expect(post.eql?(decorated_post)).to be(true)
    expect(decorated_post.eql?(decorated_post)).to be(true)
  end

  it 'equal' do
    expect(decorated_post.equal?(post)).to be(false)
    expect(post.equal?(decorated_post)).to be(false)
  end
end
