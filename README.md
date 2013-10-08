# RSpec Gherkin [![Build Status][travis-img-url]][travis-url]

[travis-img-url]: https://travis-ci.org/sheerun/rspec-gherkin.png
[travis-url]: https://travis-ci.org/rspec-gherkin

Different approach to Gherkin features in RSpec. It is based on two premises:

1. Requirements are written by **business** in semi-formal, human-readable Gherkin.
2. Automation of those is done by **programmers** in formal, machine-readable RSpec.

It resigns from the idea of regexp-parseable Cucumber features. As Uncle Bob [noticed in his article](http://blog.8thlight.com/uncle-bob/2013/09/26/AT-FAIL.html):

> I mean, the point was to get the *business* to provide a formal specification of the system so that the *programmers* could understand it. What in the name of heaven is the point of having the *programmers* write the formal specification so that the *programmers* can then understand it?

## Installation

Add to your `Gemfile` and run `bundle install`:

```ruby
group :test do
  gem 'rspec-gherkin'
end
```

## License

This gem is MIT-licensed. You are awesome.
