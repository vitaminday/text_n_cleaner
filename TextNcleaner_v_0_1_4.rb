#!/usr/bin/ruby

#TextNcleaner

#Version 0.1.4

#Prepare a subtitle txt-file for translation using online services.
#For example: Google Translate (https://translate.google.ru/).
#Save your favorite files from terrible formatting.

#Executive file:   D:\work\textcleaner\textNcleaner2.rb
#Test file: C:\Users\vit2p\download\subtitle.txt
#Test command: D:\work\textcleaner\textNcleaner2.rb C:\Users\vit2p\Downloads\subtitle.txt

#$PROGRAM_NAME = "D:/work/textcleaner/textNcleaner2.rb"

#Setup the libraries
require 'clipboard'
require 'messagebox'


#Message parameters:
@msg_symb = 72
@border_symb = "-"
@prg_name = "=== Text-N-Cleaner ==="

@usage1 = ["...We need the name of the subtitle TXT file.",
	"\n", "Please, enter the path to TXT file!"]

@usage2 = ["Your corrected file has been successfully copied to the clipboard!",
	"\n", "WARNING:", "Text length exceeds 5000 characters possible!",
	"You must use the translation function from the file.", "\n",
	"For example, you can use the following link:", 
	"https://translate.google.ru/?hl=ru&tab=TT#view=home&op=docs&sl=ru&tl=en"]

@usage3 = ["ATTENTION: File not found!!!", "\n",
	"Please, enter the path to that file."]

@usage4 = ["WARNING:", "File size exceeds 1MB.",
	"Please use the advanced translation method.",
	"\n", "Press ENTER to complete."]

@usage5 = ["ATTENTION: This file is empty!!!", "\n",
	"Please check the file or select another one."]


#Get the file name from the Command line
def get_arg
	if ARGV.length != 1 then
    message(@usage1)
    stopp
	end

	@file_name = ARGV[0]

#File existence check
	if File.exist?(@file_name) == false then
		message(@usage3)
		stopp
	end

#File name check: Is it the TXT file ????
	if File.extname(@file_name) != ".txt" then
		message(@usage1)
		stopp
	end

#Check:   File size >1Mb ????
	if File.size(@file_name) >= 1048576 then
		message(@usage4)
		stopp
	end

#Check:   File is empty ???
	if File.size?(@file_name) == nil then
		message(@usage5)
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
 		message(@usage2)
 		exec("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe", 
 			"https://translate.google.ru/?hl=ru&tab=TT#view=home&op=docs&sl=en&tl=ru")
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

def message(msg)

	border = ""
	@msg_symb.times do
		border = border + @border_symb
	end

	puts "\n", border
	
	puts @prg_name.center(@msg_symb, " "), "\n"

	msg.each do |str|
	puts str.center(@msg_symb, " ")
	end

	puts border
end

#Main
	get_arg
	get_text
	text_n_cleaner
	file_renamer
	file_writer
	send_to_clipboard
	alert_5000

#Message OK
@congrates = ["Content corrected successfully and added to clipboard!",
	"\n", "You can also get a new file here:",
	@file_name_new, "\n", "Good Lack!!!"]

MessageBox.new("Text-N-Cleaner:", message(@congrates)).show

#	message(@congrates)
#@congrates.join("\n")