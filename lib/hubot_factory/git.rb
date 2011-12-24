module HubotFactory
  module Git

    # Clone the git repository at the URL.
    #
    # Returns nothing.
    def self.clone(url)
      system "git clone #{url}"
    end

    # Initialize the current directory as a git repository.
    #
    # Returns nothing.
    def self.init
      system "git init"
    end

    # Add specific files or all if none specified to the index.
    #
    # Returns nothing.
    def self.add(items=nil)
      items = "." unless items
      system "git add #{items}"
    end

    # Commit staged changes to the git repository with the specified commit
    # message.
    #
    # Returns nothing.
    def self.commit(message)
      system "git commit -m '#{message}'"
    end

    # Push changes from a branch to a remote repository.
    #
    # Returns nothing.
    def self.push(remote=nil, branch=nil)
      remote = "origin" unless remote
      branch = "master" unless branch
      system "git push #{remote} #{branch}"
    end
  end
end
