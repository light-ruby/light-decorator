# Light Decorator

[![Build Status](https://travis-ci.org/light-ruby/light-decorator.svg?branch=master)](https://travis-ci.org/light-ruby/light-decorator)
[![Code Climate](https://codeclimate.com/github/light-ruby/light-decorator/badges/gpa.svg)](https://codeclimate.com/github/light-ruby/light-decorator)
[![Test Coverage](https://codeclimate.com/github/light-ruby/light-decorator/badges/coverage.svg)](https://codeclimate.com/github/light-ruby/light-decorator/coverage)

Easiest and fast way to decorate Ruby on Rails models. Compatible with Rails 5.0 and 4.2, 4.1, 4.0.

Decorator Pattern – What is it? Check it here:
- [Wikipedia](https://en.wikipedia.org/wiki/Decorator_pattern)
- [Thoughtbot](https://robots.thoughtbot.com/evaluating-alternative-decorator-implementations-in)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'light-decorator', '~> 1.0.0'
```

Create base class `ApplicationDecorator` in folder `app/decorators/application_decorator.rb`

```
rails g light:decorator:install
```

## Usage

Create decorator for your model. For example we will use the `User` model.
We can manually create file:

```ruby
# app/decorators/user_decorator.rb
class UserDecorator < Application
  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
```

Or we can just use command to create this file:

```
rails g decorator User
```

Decorate your model in controller or anywhere.

```ruby
# Single record
User.find(params[:id]).decorate
User.find_and_decorate(params[:id])
User.decorate.find(params[:id])

# Collection
User.all.decorate
User.decorate
User.limit(10).decorate
User.decorate.limit(10)

# Options
User.find_and_decorate(params[:id], with: AnotherUserDecorator)

# Associations will be decorated automatically
user = User.find_and_decorate(params[:id])
user.decorated? # true
user.comments.decorated? # true
user.comments.first.decorated? # true
```

Example of Decorator
```ruby
class UserDecorator < ApplicationDecorator
  def full_name
    "#{object.first_name} #{object.last_name}"
    # or
    "#{o.first_name} #{o.last_name}"
  end
  
  def full_name_link
    helpers.link_to full_name, user_path(object)
    # or
    h.link_to full_name, user_path(o)
  end
end
```

## Next steps

- [x] Create installation generator
- [x] Create decorator generator
- [ ] Create configuration file

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/light-ruby/light-decorator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

