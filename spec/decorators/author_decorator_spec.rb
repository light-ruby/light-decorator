require 'spec_helper'

RSpec.describe AuthorDecorator do
  let(:author)           { create(:author) }
  let(:decorated_author) { author.decorate }

  it 'decorator exist' do
    expect { AuthorDecorator }.to_not raise_error
  end

  it 'decorate author via method' do
    author.posts.count
    expect(author).to_not be_decorated
    expect(author.decorate).to be_decorated
    expect(author.decorate(with: AuthorDecorator)).to be_decorated
  end

  it 'decorate author via class' do
    expect(author).to_not be_decorated

    expect(AuthorDecorator.new(author)).to be_decorated
    expect(AuthorDecorator.decorate(author)).to be_decorated
  end

  it 'decoration with not existed decorator' do
    expect { author.decorate(with: 'SuperDecorator') }.to raise_error Light::Decorator::NotFound
  end

  it 'soft decoration' do
    expect(author.decorate(soft: true, with: 'SuperDecorator')).to eql(author)
  end

  it 'decorate collection' do
    expect(Author.all).to_not be_decorated
    expect(Author.decorate).to be_decorated

    create(:author)
    expect(Author.all.take).to_not be_decorated
    expect(Author.decorate.take).to be_decorated
  end

  it 'full name method' do
    expect(decorated_author.full_name).to eql("#{author.first_name} #{author.last_name}")
  end

  it 'full name method for collection' do
    5.times { create(:author) }

    authors = Author.all
    authors.decorate.each do |author|
      expect(author.full_name).to eql("#{author.first_name} #{author.last_name}")
    end
  end

  it 'decorate has many association' do
    5.times { create(:post, author: author) }

    expect(author.reload.decorate.posts).to be_decorated
    expect(author.reload.decorate.posts.take).to be_decorated

    author.decorate.posts.each do |post|
      expect(post).to be_decorated
    end

    author.decorate.posts.where(published: true).each do |post|
      expect(post).to be_decorated
    end

    author.decorate.posts.limit(3).each do |post|
      expect(post).to be_decorated
    end
  end

  it 'decorates eager loading' do
    3.times do
      author = create(:author)
      3.times { create(:post, author: author) }
    end

    Author.includes(:posts).decorate.each do |author|
      expect(author).to be_decorated

      author.posts.each do |post|
        expect(post).to be_decorated
      end
    end

    Author.references(:posts).decorate.each do |author|
      expect(author).to be_decorated

      author.posts.each do |post|
        expect(post).to be_decorated
      end
    end
  end

  it 'decorates deep eager loading' do
    Author.includes(posts: :tags).decorate.each do |author|
      expect(author).to be_decorated

      author.posts.each do |post|
        expect(post).to be_decorated

        post.tags.each do |tag|
          expect(tag).to be_decorated
        end
      end
    end
  end
end
