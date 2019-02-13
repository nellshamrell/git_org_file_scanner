require 'git_org_file_scanner/version'
require 'octokit'

module GitOrgFileScanner
  # Scans all repos in a Github org for a specified file
  class Scanner
    attr_accessor :org

    def initialize(access_token, org, type = 'sources')
      @octokit_client = setup_client(access_token)
      @org = org
      @type = type
      @org_repositories = org_repositories
    end

    # setup an oktokit client with auto_pagination turned on so we get all the repos
    # returned even in large organizations
    #
    # @param token [String] the github access token
    # @return [Octokit::Client] the oktokit client object
    def setup_client(token)
      client = Octokit::Client.new(access_token: token)
      client.auto_paginate = true
      client
    end

    def contain_file(file)
      repos = []

      @org_repositories.each do |repo|
        repos << repo[:full_name] if contains_file?(repo[:full_name], file)
        next
      end

      repos
    end

    def missing_file(file)
      repos = []

      @org_repositories.each do |repo|
        next if contains_file?(repo[:full_name], file)

        repos << repo[:full_name]
      end

      repos
    end

    private

    def org_repositories
      @octokit_client.org_repositories(@org, {:type => @type})
    end

    def contains_file?(repo_name, file)
      @octokit_client.contents(repo_name, path: file)
      true
    rescue Octokit::NotFound
      false
    end
  end
end
