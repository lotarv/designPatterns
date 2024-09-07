puts "Enter ruby command: ";
ruby_command = $stdin.gets.chomp;

puts "Enter OS command: ";
os_command = $stdin.gets.chomp;

puts "Executing ruby command...";

eval(ruby_command);

puts "Executing os command...";

exec(os_command);