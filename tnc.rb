#!/usr/bin/ruby

#Text-n-Cleaner

#Version 0.1.5

#Prepare a subtitle txt-file for translation using online services.
#For example: Google Translate (https://translate.google.ru/).
#Save your favorite files from terrible formatting.

#For example:
#Executive file:   D:\work\textcleaner\tnc.rb
#Test file: C:\Users\vin\download\subtitle.txt
#Test command: D:\work\textcleaner\tnc.rb C:\Users\vin\Downloads\subtitle.txt


#Setup the libraries
require 'clipboard'
require 'messagebox'


#Message parameters:
@msg_symb = 72
@border_symb = "-"
@prg_name = "Text-N-Cleaner"

@usage1 = ["...We need the name of the subtitle TXT file.",
	"\n", "Please, enter the path to TXT file!"]

@usage2 = ["Your corrected file has been successfully copied to the clipboard!",
	"\n", "WARNING: Alert 5000!", "\n", "Text length exceeds 5000 characters possible!",
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
	MessageBox::Warning.new(@prg_name, message2(@usage1)).show
	exit(0)
	end

	@file_name = ARGV[0]

#File existence check
	if File.exist?(@file_name) == false then
		MessageBox::Warning.new(@prg_name, message2(@usage3)).show
		exit(0)
	end

#File name check: Is it the TXT file ????
	if File.extname(@file_name) != ".txt" then
		MessageBox::Warning.new(@prg_name, message2(@usage1)).show
		exit(0)
	end

#Check:   File size >1Mb ????
	if File.size(@file_name) >= 1048576 then
		MessageBox::Warning.new(@prg_name, message2(@usage4)).show
		exit(0)
	end

#Check:   File is empty ???
	if File.size?(@file_name) == nil then
		MessageBox::Warning.new(@prg_name, message2(@usage5)).show
		exit(0)
	end
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
 		MessageBox::Warning.new(@prg_name, message2(@usage2)).show
 		exec("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe", 
 			"https://translate.google.ru/?hl=ru&tab=TT#view=home&op=docs&sl=en&tl=ru")
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

def message2(msg)
	a = []

	msg.each do |str|
	a << str.center(@msg_symb, " ")
	end

	msg = a.join("\n")
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

MessageBox.new(@prg_name, message2(@congrates)).show
exit(0)