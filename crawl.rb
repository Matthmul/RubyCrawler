#!/usr/bin/ruby

require_relative "allegro"

product = Allegro.new(ARGV[0])

puts "--------------------------"
puts "Tytul:    #{product.title}"
puts "Cena:    #{product.price}"