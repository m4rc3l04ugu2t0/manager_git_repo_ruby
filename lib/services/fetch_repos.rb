class FetchRepos
  REPOS_PATH = "#{File.dirname(__FILE__)}/../../repos"

  def self.call(repos)
    run repos
  end

  def self.run(repos)
    repos.each do |repo|
      create_owner_folder repo.owner
      owners_folders = Dir["#{REPOS_PATH}/#{repo.owner}/*"].map do |folder|
        folder.split '/'.last
      end

      exist_folder = owners_folders.include? project_folder_name repo

      repo_folder = "#{REPOS_PATH}/#{repo.owner}/#{project_folder_name(repo)}"

      if exist_folder
        system "git -C #{repo_folder} pull"
      else
        system "git clone #{repo.url} #{repo_folder}"
      end
    end

    puts "\nRepos atualizados com sucesso"
    sleep 2
  end

  def self.create_owner_folder(owner)
    system 'mkdir', '-p', "#{REPOS_PATH}/#{owner}"
  end

  def self.project_folder_name(repo)
    repo.url.split('/').last
  end
end
