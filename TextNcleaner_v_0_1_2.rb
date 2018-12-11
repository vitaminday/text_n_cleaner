#!/usr/bin/ruby

#TextNcleaner

#Prepare a subtitle txt-file for translation using online services.
#For example: Google Translate (https://translate.google.ru/).
#Save your favorite files from terrible formatting.

#Executive file:   D:\work\textcleaner\textNcleaner2.rb
#Test file: C:\Users\vit2p\download\subtitle.txt
#Test command: D:\work\textcleaner\textNcleaner2.rb C:\Users\vit2p\Downloads\subtitle.txt

#Setup the libraries
require 'clipboard'

#Initialize the variable
initialize
	@file_name = nil
	@bad_text = nil
	@file_name_new = nil
	@good_text = nil

#Get the file name from the Command line
def get_arg
	if ARGV.length != 1 then
    usage1
    exit(1)
	end

	@file_name = ARGV[0]

#File existence check
	if File.exist?(@file_name) == false then
		usage3
		exit(1)
	end

#File name check: Is it the TXT file ????
	if File.extname(@file_name) != ".txt" then
		usage1
		exit(1)
	end

#Check:   File size >1Mb ????
#	size = File.size(@file_name)
#	print "File size:  ", size

	if File.size(@file_name) >= 1048576 then
		usage4
		exit(1)
	end

#TODO: File size = 0 ???
#File.size?

end

#Get text from the file
def get_text
	file = File.open(@file_name)
	@bad_text = file.read
	file.close
end

#Cleaning the text
def text_n_cleaner
	@good_text = @bad_text.tr("\n"," ")
end

#Check the text length: >5000 characters ???
def alert_5000
 	total_characters = @good_text.length
 	if total_characters >= 5000 then
 		usage2
 		exit(0)
 	end
end

#Create a new file name
def file_renamer
	@file_name_new = @file_name.gsub(/.txt/,"-new.txt")
end

#Create a new file
def file_writer
	File.open(@file_name_new,"w") do |file|
	file.puts @good_text
	end
end

#Send the clean text to clipboard
def send_to_clipboard
	Clipboard.copy(@good_text)
end

#Problem Report: No TXT file
def usage1
	puts "\n------------------------------------------------"
	puts "             === TextNCleaner ==="
	puts "\n ...We need the name of the subtitle TXT file."
    puts "     Please, enter the path to that file."
    puts "\n------------------------------------------------"
end

#Problem Report: Text length exceeds 5000 characters.
def usage2
	puts "\n-------------------------------------------------------------------------"
	puts "                       === TextNCleaner ===                             \n"
	puts "\n   Your corrected file has been successfully copied to the clipboard!"
	puts "\n                            WARNING:"
	puts "\n          Text length exceeds 5000 characters possible!"
	puts "        Please use the translation function from the file."
	puts "\n           For example, you can use the following link:"
	puts " https://translate.google.ru/?hl=ru&tab=TT#view=home&op=docs&sl=ru&tl=en"
	puts "\n-------------------------------------------------------------------------"
end

#Problem Report: File not found
def usage3
	puts "\n-------------------------------------------"
	puts "           === TextNCleaner ==="
	puts "\n       ATTENTION: File not found!!!"
	puts "   Please, enter the path to that file."
	puts "\n-------------------------------------------"
end

#Problem Report: File size exceed 1Mb
def usage4
	puts "\n---------------------------------------------"
	puts "           === TextNCleaner ==="
	puts "\n                 WARNING:"
	puts "         File size exceeds 1MB."
	puts " Please use the advanced translation method."
	puts "\n---------------------------------------------"
end

#Successful completion
def congrates
	puts "\n---------------------------------------------------------------------"
	puts "                      === TextNCleaner ===                             \n"
	puts "\n Your corrected file has been successfully copied to the clipboard!"
	puts "\n              You can take yours new file here:"
	puts "          #{@file_name_new}"
	puts "\n                      --- Good Lack! ---"
	puts "---------------------------------------------------------------------"
end

#def main
	get_arg
	get_text
	text_n_cleaner
	file_renamer
	file_writer
	send_to_clipboard
	alert_5000
	congrates
#end