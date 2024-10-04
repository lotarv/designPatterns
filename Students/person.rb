class Person
    attr_accessor :id, :git

    #git validation
    def self.valid_git?(git)
        git.nil? || %r{^https?://github\.com/[a-zA-Z0-9_\-]+$}.match?(git)
    end

    def validate_git?()
        !self.git.nil?
    end

    def get_full_name()
        if @full_name
            return @full_name
        end
        "#{self.surname} #{self.name[0].upcase()}. #{self.middle_name[0].upcase()}."
    end

    def get_contact()
        if @contact
            return @contact
        end

        getting_info = {
            "telegram" => self.telegram,
            "телефон" => self.phone,
            "email" => self.email,
            
        }

        result_string = ''

        #Берем первое найденное значение
        getting_info.each do |key, value|
            if value
                result_string += "#{key}: #{value} "
                break
            end  
        end

        result_string
    end

    #setters
    private def git=(git)
        if !self.class.valid_git?(git)
            raise ArgumentError, "invalid git link"
        end
        @git = git
    end

    private def id=(id_value)
        @id = id_value
    end
end