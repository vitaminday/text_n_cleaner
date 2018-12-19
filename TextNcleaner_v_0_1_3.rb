#!/usr/bin/ruby

#TextNcleaner

#Prepare a subtitle txt-file for translation using online services.
#For example: Google Translate (https://translate.google.ru/).
#Save your favorite files from terrible formatting.

#Setup the libraries
require 'clipboard'

#Initialize the variable
initialize
	@file_name = nil
	@bad_text = nil
	@file_name_new = nil
	@good_text = nil
	@msg_symb = 72

#Get the file name from the Command line
def get_arg
	if ARGV.length != 1 then
    usage1
    stopp
	end

	@file_name = ARGV[0]

#File existence check
	if File.exist?(@file_name) == false then
		usage3
		stopp
	end

#File name check: Is it the TXT file ????
	if File.extname(@file_name) != ".txt" then
		usage1
		stopp
	end

#Check:   File size >1Mb ????
	if File.size(@file_name) >= 1048576 then
		usage4
		stopp
	end

#Check:   File is empty ???
	if File.size?(@file_name) == nil then
		usage5
		stopp
	end
end

#Short message and exit
def stopp
	str4 = STDIN.gets
	exit(0)
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
 		exec("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe", "https://translate.google.ru/?hl=ru&tab=TT#view=home&op=docs&sl=en&tl=ru")
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

def header
	puts "\n-------------------------------------------------------------------------"
	puts "=== TextNCleaner ===".center(@msg_symb, ' '), "\n"
end

def footer
	puts "\n-------------------------------------------------------------------------"
end

#Problem Report: No TXT file
def usage1
	header
	puts "...We need the name of the subtitle TXT file.".center(@msg_symb, ' ')
    puts "Please, enter the path to TXT file.".center(@msg_symb, ' ')
    footer
end

#Problem Report: Text length exceeds 5000 characters.
def usage2
	header
	puts "Your corrected file has been successfully copied to the clipboard!".center(@msg_symb, ' ')
	puts "\n", "WARNING:".center(@msg_symb, ' ')
	puts "\n", "Text length exceeds 5000 characters possible!".center(@msg_symb, ' ')
	puts "Please use the translation function from the file.".center(@msg_symb, ' ')
	puts "\n", "For example, you can use the following link:".center(@msg_symb, ' ')
	puts "https://translate.google.ru/?hl=ru&tab=TT#view=home&op=docs&sl=ru&tl=en".center(@msg_symb, ' ')
	footer
end

#Problem Report: File not found
def usage3
	header
	puts "ATTENTION: File not found!!!".center(@msg_symb, ' ')
	puts "Please, enter the path to that file.".center(@msg_symb, ' ')
	footer
end

#Problem Report: File size exceed 1Mb
def usage4
	header
	puts "WARNING:".center(@msg_symb, ' ')
	puts "File size exceeds 1MB.".center(@msg_symb, ' ')
	puts "Please use the advanced translation method.".center(@msg_symb, ' ')
	print "\n\n", "Press ENTER to complete.".center(@msg_symb, ' '), "\n"
	footer
end

#Problem Report: File have 0 byte size
def usage5
	header
	puts "ATTENTION: This file is empty!!!".center(@msg_symb, ' ')
	puts "Please check the file or select another one.".center(@msg_symb, ' ')
	footer
end

#Successful completion
def congrates
	header
	puts "Your corrected file has been successfully copied to the clipboard!".center(@msg_symb, ' ')
	puts "\n", "You can take yours new file here:".center(@msg_symb, ' ')
	puts "#{@file_name_new}".center(@msg_symb, ' ')
	puts "\n", "--- Good Lack! ---".center(@msg_symb, ' ')
	footer
end

	get_arg
	get_text
	text_n_cleaner
	file_renamer
	file_writer
	send_to_clipboard
	alert_5000
	congrates