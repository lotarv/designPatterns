require './student.rb'

class Student_short
    attr_accessor :id, :full_name, :git, :contact
    private_class_method :new


    def self.parse_from_string(string)
        full_name, git, contact = string.split(', ')
        contact = contact.split()[-1]
        return full_name, git, contact
    end
        

    def initialize(id, full_name, git, contact)
        self.id = id
        self.full_name = full_name
        self.git = git
        self.contact = contact
    end

    def self.new_from_student_obj(student)
        self.new(
            student.id,
            student.get_full_name,
            student.git,
            student.get_contact.split()[-1]
               )
    end

    def self.new_from_string(id, string)
        full_name, git, contact = self.parse_from_string(string)
        self.new(id, full_name, git, contact)
    end
end