#Идеальный вес. Программа запрашивает у пользователя имя и рост 
#и выводит идеальный вес по формуле (<рост> - 110) * 1.15, 
#после чего выводит результат пользователю на экран с обращением по имени.
#Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"

weight_coeficient=110 

puts "You name: "
name = gets.chomp.capitalize

puts "You height in centimeters"
height = gets.to_i

ideal_weight = height - weight_coeficient

if ideal_weight < 0
	puts "#{name}, your weight is already optimal"
else
	puts "#{name}, your ideal weight is #{ideal_weight} kg."
end
