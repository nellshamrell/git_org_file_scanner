require "git_org_file_scanner/version"
require "octokit"

module GitOrgFileScanner
  class Scanner
    attr_accessor :org

    def initialize(org)
      @octokit_client = Octokit::Client.new
      @org = org
    end

    def contain_file(file)
      repos_with_file = []
      org_repositories.each do |repo|
        contains_file?(repo[:full_name], file) ? repos_with_file << repo : next 
        begin
          @octokit_client.contents(repo[:full_name], path: file)
          repos_with_file << repo[:full_name]
        rescue
          next
        end
      end

      repos_with_file
    end

    def missing_file(file)
      repos_without_file = []

      org_repositories.each do |repo|
        contains_file?(repo[:full_name], file) ? next : repos_without_file << repo[:full_name]
      end

      repos_without_file
    end

    private

    def org_repositories
      @octokit_client.org_repositories(org)
    end

    def contains_file?(repo_name, file)
      begin
        @octokit_client.contents(repo_name, path: file)
        true
      rescue
        false
      end
    end
  end
end
