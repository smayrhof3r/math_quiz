# math quiz

## A first attempt at MVC model web app
As part of the le Wagon bootcamp, we are currently learning MVC model in the console. I got a taste of Sinatra with the 'cookbook' challenge, so am making my second app - a math quiz for the kids :)
## steps to run this as a local app
1. fork repository into your preferred coding tool
2. run 'rackup config.ru' to start the sinatra loop
3. copy the relevant path indicated in your terminal (eg. localhost:4567) to a web browser and enjoy!

## steps to run this on ngrok for others to access
1. install ngrok
2. run ```ngrok http 4567```
3. copy the relevant http://.....ngrok.io path indicated in your terminal to a web browser and share! Note this only works when it's running on your local terminal

## app functions
Currently it's a simple math quiz
* user can select which rows of the multiplication table to include
* user can select a 20 question challenge or all questions
* the program displays the questions in random order, and doesn't move ahead from one question to the next until it's right
* feedback to the user is in the button (eg. 'try again!')

**Required improvements are listed in the issues - happy for your help in resolving them!**
