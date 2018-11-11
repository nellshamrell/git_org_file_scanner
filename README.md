# GitOrgFileScanner

This Gem allows you to scan all GitHub repos in a GitHub organization to determine if they contain or if they are missing a specified file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_org_file_scanner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_org_file_scanner

## Usage

Access the library in Ruby

```ruby
require 'git_org_file_scanner'
```

Let's say we want a list of all repos in the [habitat-sh GitHub Org](https://github.com/habitat-sh) that DO contain a CONTRIBUTING.md file. We would request that list like this:

```ruby
scanner = GitOrgFileScanner::Scanner.new('habitat-sh')
scanner.contain_file('CONTRIBUTING.md')
```

Now what if we want a list of all repos that do NOT contain a CONTRIBUTING.md file?

```ruby
scanner.missing_file('CONTRIBUTING.md')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nellshamrell/git_org_file_scanner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GitOrgFileScanner project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/git_org_file_scanner/blob/master/CODE_OF_CONDUCT.md).
