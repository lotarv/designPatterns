puts "What is your name?";

name = ARGV[0];
# ARGV.clear;
puts "Hello, #{name}, What is your favourite programming language?";

lang = $stdin.gets.chomp

case lang
when "ruby"
  puts "lickspittle!"
when "javascript"
  puts "weak!"
when "python"
  puts "omg, freak"
else
  puts "It will be Ruby very soon!"
end

