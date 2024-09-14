class Student
    attr_accessor :id, :name,:surname, :middle_name,:phone,:telegram,:email,:git

    def self.valid_number?(phone_number)
        phone_number.nil? || /^(?:\+7|8)[\s-]?(?:\(?\d{3}\)?[\s-]?)\d{3}[\s-]?\d{2}[\s-]?\d{2}$/.match?(phone_number)
    end

    def initialize(params)
        raise "id not provided" if !params[:id]
        self.id = params[:id]

        raise "name not provided" if !params[:name]
        self.name = params[:name]

        raise "surname not provided" if !params[:surname]
        self.surname = params[:surname]

        raise "middle_name not provided" if !params[:middle_name]
        self.middle_name = params[:middle_name]

        self.phone = params[:phone]
        self.telegram = params[:telegram]
        self.email = params[:email]
        self.git = params[:git]
    end

    def showInfo()
        puts "*** #{@name} #{@middle_name} #{@surname} ***"
        puts "id: #{@id}"
        puts "phone: #{@phone}" if @phone
        puts "telegram: #{@telegram}" if @telegram
        puts "email: #{@email}" if @email
        puts "git : #{@git}" if @git
        puts "***********************"
    end

    def phone=(phone_number)
        if !self.class.valid_number?(phone_number)
            raise ArgumentError, "invalid phone number"
        end
        @phone = phone_number
        
        
    end

end

  