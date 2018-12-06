# watch me learn how 2D arrays work in ruby lol

rows = 5
cols = 10
arr = Array.new(rows){Array.new(cols, 0)}

# access something in range
arr[2][3] = 3

# access something out of x range
#arr[5][6] = 7
# THIS THROWS ERROR (nil[6] doesn't work duh), will need to check x boundary for nil

# access something out of y range
arr[1][25] = 13
# THIS IS FINE, fills in the gap with nils, so we need to check for nils (or just use nil instead of 0?)

puts arr[5].nil?
# returns true

arr[8] = Array.new(cols, 0)
# this caused my print to throw error (nil.join lol) so I added nil check
# otherwise did what I wanted, filled in the missing rows with nils
# so we should check every x value for nil before accessing it, and if nil, initialize the row

# neatly print the whole mess to see what happened to the array
arr.each { |x|
 if x.nil?
   puts "nil"
 else
   puts x.join(" ")
 end
}
