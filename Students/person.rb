class Person
    attr_accessor :id, :git

    #git validation
    def self.valid_git?(git)
        git.nil? || %r{^https?://github\.com/[a-zA-Z0-9_\-]+$}.match?(git)
    end

    def self.parse_from_string(string)
        full_name, git, contact = string.split(', ')
        contact = contact.split()[-1]
        return full_name, git, contact
    end

    private def git=(git)
        if !self.class.valid_git?(git)
            raise ArgumentError, "invalid git link"
        end
        @git = git
    end

end