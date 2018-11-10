require "git_org_file_scanner/version"
require "octokit"

module GitOrgFileScanner
  class Scanner
    attr_accessor :org

    def initialize(org)
      @octokit_client = Octokit::Client.new
      @org = org
    end

    def check_for_file(file)
      org_repositories.each do |repo|
        @octokit_client.contents(repo[:full_name], path: file)
      end
    end

    def org_repositories
      @octokit_client.org_repositories(org)
    end
  end
end
