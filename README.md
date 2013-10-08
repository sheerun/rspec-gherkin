# RSpec Gherkin [![Build Status][travis-img-url]][travis-url]

[travis-img-url]: https://travis-ci.org/sheerun/rspec-gherkin.png
[travis-url]: https://travis-ci.org/rspec-gherkin

Different approach to Gherkin features in RSpec. It is based on two premises:

1. Requirements are written by **business** in semi-formal, human-readable Gherkin.
2. Automation of those is done by **programmers** in formal, machine-readable RSpec.

It resigns from the idea of regexp-parseable Cucumber features. As Uncle Bob [noticed in his article](http://blog.8thlight.com/uncle-bob/2013/09/26/AT-FAIL.html):

> I mean, the point was to get the *business* to provide a formal specification of the system so that the *programmers* could understand it. What in the name of heaven is the point of having the *programmers* write the formal specification so that the *programmers* can then understand it?

## Installation

Just add this gem to `test` group in `Gemfile`:

```ruby
group :test do
  gem 'rspec-gherkin'
end
```

## Usage

1. Put your requirements in `features` directory under application's root path:

  `features/manage_articles.feature`

  ```gherkin
  Feature: Manage Articles
    In order to make a blog
    As an author
    I want to create and manage articles

    Scenario: Articles List
      Given I have articles titled Pizza, Breadsticks
      When I go to the list of articles
      Then I should see "Pizza"
      And I should see "Breadsticks"
  ```

2. Put specs for for those features in `spec/features` directory:

  `spec/features/manage_articles_spec.rb`

  ```ruby
  require 'spec_helper'

  feature 'Manage Articles' do
    scenario 'Articles List' do
      create(:article, :title => "Pizza")
      create(:article, :title => "Breadsticks")
      visit articles_path
      expect(page).to have_content 'Pizza'
      expect(page).to have_content 'Breadsticks'
    end
  end
  ```

In specs you can use Capybara, FactoryGirl, helpers, and whatever you want.

## License

This gem is MIT-licensed. You are awesome.
