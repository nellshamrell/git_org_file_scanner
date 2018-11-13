require 'git_org_file_scanner/version'
require 'octokit'

module GitOrgFileScanner
  # Scans all repos in a Github org for a specified file
  class Scanner
    attr_accessor :org

    def initialize(org)
      @octokit_client = Octokit::Client.new
      @org = org
      @org_repositories = org_repositories
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
      @octokit_client.org_repositories(org)
    end

    def contains_file?(repo_name, file)
      @octokit_client.contents(repo_name, path: file)
      true
    rescue Octokit::NotFound
      false
    end
  end
end
