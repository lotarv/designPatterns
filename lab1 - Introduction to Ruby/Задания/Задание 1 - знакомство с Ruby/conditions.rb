age = 18
if (age < 18) 
  puts "access denied"
else 
  puts "access allowed"
end


unless age < 18
  puts "access allowed"
else 
  puts "access denied"
end

case age
when 0..17
  puts "access denied"
else
  puts "access allowed"
end

 puts (age >= 18 ) ? "Access allowed" : "Access denied"