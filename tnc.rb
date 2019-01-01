#!/usr/bin/ruby

#TextCleaner
#
#Do you want to get a high-quality translation of the text?
#Save your files from terrible formatting.

require 'clipboard'

if ARGV.length != 1 then
    puts "\n...We need the name of the subtitle file."
    puts "Please, enter the path to that file."
    exit(1)
end

file_name = ARGV[0]

file = File.open(file_name)
bad_text = file.read
file.close

good_text = bad_text.tr("\n"," ")

file_name_new = file_name.gsub(/.txt/,"-new.txt")

File.open(file_name_new,"w") do |file|
file.puts good_text
end

Clipboard.copy(good_text)

puts "\n---------------------------------------------------------------------"
puts "                     === TextCleaner ===                             \n"
puts "\nYour corrected file has been successfully copied to the clipboard!"
puts "\nYou can take yours new file here:"
puts file_name_new
puts "\n                     --- Good Lack! ---"
puts "---------------------------------------------------------------------"
