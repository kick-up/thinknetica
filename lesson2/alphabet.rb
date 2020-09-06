#Заполнить хеш гласными буквами, где значением будет 
#являтся порядковый номер буквы в алфавите (a - 1).
alphabet = ('a'..'z')
count = (1..26)

vowel = ("a", "e", "i", "o", "u")

vowels_hash=Hash.new

alphabet.each_index do |letter , index|
  vowels_hash[letter] = index if vowels.include?(letter)
end

puts vowels_hash


