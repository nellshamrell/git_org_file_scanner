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

You will need a [GitHub Personal Access Token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) to authenticate to the GithHub API.

We can initialize the scannerlike this:
```ruby
scanner = GitOrgFileScanner::Scanner.new('<your GitHub access token>', 'habitat-sh')
```

Let's say we want a list of all repos in the [habitat-sh GitHub Org](https://github.com/habitat-sh) that DO contain a CONTRIBUTING.md file. We would request that list like this:

```ruby
scanner.contain_file('CONTRIBUTING.md')
=> ["habitat-sh/habitat", "habitat-sh/core-plans", "habitat-sh/habitat-launch", "habitat-sh/urlencoded", "habitat-sh/habitat-operator"] 
```

Now what if we want a list of all repos that do NOT contain a CONTRIBUTING.md file?

```ruby
scanner.missing_file('CONTRIBUTING.md')
=> ["habitat-sh/habitat-example-plans", "habitat-sh/net-habitat", "habitat-sh/habitat-aspnet-sample", "habitat-sh/habitat-windows-package", "habitat-sh/language-habitat", "habitat-sh/rust-zmq", "habitat-sh/redis-postgres-migrator", "habitat-sh/habitat-aspnet-full", "habitat-sh/ipc-channel", "habitat-sh/prost", "habitat-sh/frank_jwt", "habitat-sh/sample-node-app", "habitat-sh/expresso", "habitat-sh/homebrew-habitat", "habitat-sh/sample-rails-app", "habitat-sh/windows-service", "habitat-sh/kubernetes-the-hab-way", "habitat-sh/guide-node", "habitat-sh/guide-ruby", "habitat-sh/testapp", "habitat-sh/windows-service-sample", "habitat-sh/national-parks"]
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
