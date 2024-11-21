require 'pg'
require_relative "../student.rb"


connection = PG.connect(
    dbname: 'postgres',
    user: "postgres",
    password: "password",
    host:"localhost",
    port:5432
)

result = connection.exec("SELECT * FROM student")

result.each do |row|
    row["id"] = row["id"].to_i
    puts row
end