RSpec.describe GitOrgFileScanner do
  it "has a version number" do
    expect(GitOrgFileScanner::VERSION).not_to be nil
  end

  context "connecting to github" do
    let(:org) { 'my-org' }

    it "initialize a connection to the GitHub API" do
      expect(Octokit::Client).to receive(:new)

      GitOrgFileScanner::Scanner.new(org)
    end
  end

  context 'getting org repos' do
    let(:org) { 'my-org' }
    let(:scanner) { GitOrgFileScanner::Scanner.new(org)}
    let(:github_client) { Octokit::Client.new }
    
    before do
      allow(Octokit::Client).to receive(:new).and_return(github_client)
    end

    it 'gets a list of repos in the org' do
      expect(github_client).to receive(:org_repositories).with(org)

      scanner.org_repositories
    end
  end

  context 'scanning org repos for a file' do
    let(:org) { 'my-org' }
    let(:org_repos_response) do 
      [{id: 36098429, name: "habitat", full_name:"habitat-sh/habitat"},{id: 116978574, name: "national-parks", full_name: "habitat-sh/national-parks"}]
    end
    let(:scanner) { GitOrgFileScanner::Scanner.new(org)}
    let(:github_client) { Octokit::Client.new }
    let(:file) { 'CONTRIBUTING.md' }

    before do
      allow(Octokit::Client).to receive(:new).and_return(github_client)
      allow(github_client).to receive(:org_repositories).and_return(org_repos_response)
    end

    context 'returning list of repos that DO contain the file' do
      before do
        allow(github_client).to receive(:contents).with('habitat-sh/habitat', path: file).and_return('yes')
        allow(github_client).to receive(:contents).with('habitat-sh/national-parks', path: file).and_raise('error')
      end

      it 'checks each repo for the file' do
        expect(github_client).to receive(:contents).with('habitat-sh/habitat', path: file).ordered
        expect(github_client).to receive(:contents).with('habitat-sh/national-parks', path: file).ordered
        scanner.contain_file(file)
      end

      it 'includes repos that contain the file' do
        expect(scanner.contain_file(file)).to include('habitat-sh/habitat')
      end

      it 'excludes repos that do not contain the file' do
        expect(scanner.contain_file(file)).not_to include('habitat-sh/national-parks')
      end
    end

    context 'return a list of repos that DO NOT contain the file' do
      before do
        allow(github_client).to receive(:contents).with('habitat-sh/habitat', path: file).and_return('yes')
        allow(github_client).to receive(:contents).with('habitat-sh/national-parks', path: file).and_raise('error')
      end

      it 'checks each repo for the file' do
        expect(github_client).to receive(:contents).with('habitat-sh/habitat', path: file).ordered
        expect(github_client).to receive(:contents).with('habitat-sh/national-parks', path: file).ordered
        scanner.contain_file(file)
      end

      it 'includes repos that DO NOT contain the file' do
        expect(scanner.missing_file(file)).to include('habitat-sh/national-parks')
      end

      it 'excludes repos that do contain the file' do
        expect(scanner.missing_file(file)).not_to include('habitat-sh/habitat')
      end
    end
  end
end
