class Student
    attr_accessor :id, :name,:surname, :middle_name,:phone,:telegram,:email,:git
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
end
