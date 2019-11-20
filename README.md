# cambridge_dict_cmd

This is a command line tool I used myself to look up the meaning of some words in the
cambrige dictionary websites.

At first I found it is upset to open a browser every time I need to look up a word, so I write this simple program.

The program actually read the input words and concate it with the url of cambrige dictionary website. Then download
the web page and parse it to find out the meaning of the words. I use regular expression matching to achieve this.

However, the content of the website has changed now. So the pattern matching doesn't work anymore. This program is now
useless. Maybe I will update it, or come up with an idea that I do not have to change the pattern every time the websites
change it.
