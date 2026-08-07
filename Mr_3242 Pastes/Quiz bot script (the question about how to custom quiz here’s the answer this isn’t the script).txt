How to add custom categories and questions

First, let's go over the difference between a category, a quiz, and a question:

Category: A group/container of one or more quizzes about the same topic. Two categories can never share a name. Some examples of categories included with the script are:
Geography
Science
Sayings and Idioms
Quiz (created automatically when you add a category): A group/container that can include any number of questions. Just like categories, two quizzes can never have the same name. Some examples are:
Science1
Science2
Math-easy
Biology
Question: A single question. Includes information such as question text, the correct and wrong answers, and the amount of points that an user gets when they answer correctly. An example of a question in the "Chemistry" quiz is:
What is the chemical formula of water? [worth 1 point]
H2O
CO2
O2
2HO
You will only be dealing with categories and questions while creating custom categories; quizzes will be handled automatically by the script.

The script returns the CustomCategoryManager class, which can be used to create custom categories using the CustomCategoryManager.New() function.

local CustomCategoryManager = loadstring(game:HttpGet("https://pastebin.com/raw/HSqBVKTm"))()
local spanish = CustomCategoryManager.New("Spanish") -- create a new category
The CustomCategoryManager.New("Category Name") function will create a new category with the name you specifed. If the category already exists, it will simply add a new quiz to the existing category. For the sake of this tutorial, I will be creating a Spanish category with questions about the meanings of Spanish words.

Note: You should never worry about two categories using the same name. Just enter your desired category name, and the script will automatically handle the naming for you.

Now that you have created a category, you will need to add some questions to it. You can do this by using the :Add() method of the category you just created:

spanish:Add("What does the word 'Agua' mean in Spanish?", {"Water", "Milk", "Dog", "The number 5"}, 2)
The :Add() method accepts three arguments:

The question text (string). This is the message that the script will send once it reaches this question. Make it short and concise. "What does the word 'Agua' mean in Spanish?"
Possible choices (table containing a list of strings). The first item in the table is the correct answer. The order you specify the answer options in does not affect the order they are sent in. The order they are sent in will always be randomized. {"Water", "Milk", "Dog", "The number 5"}. The correct answer here is Water, since it is the first item.
Number of points. (number, optional). If you do not specify this value, the default (1) will be used. This is the amount of points the person who answered the question will receive. I recommend only setting this to 2 for hard questions. Otherwise, leave it blank to use the default.
That's it! You've created your first category with one question. Obviously, you should add more than one question to your category (I recommend about 5), but there is no hard-coded limit. You can add as many or as little as you please. This category is treated the same way as the premade categories—you can choose it from the dropdown menu, type its name in, and it can even be played automatically through autoplay!

These are some tips/rules that'll help you make good categories:

AI is a great tool for creating questions. I've personally had the most success with Claude.
Have either three or four options per question, and make sure the number of options is consistent throughout the whole quiz! Don't have three options in one question and then suddenly four in the next; it'll cause a lot of confusion for the players.
Include five questions per quiz. I found this to be the sweet spot—not too long, not too short.
Don't make your quizzes too hard. The average Roblox player should be able to answer them. Remember: people are having the most fun when they know the answers.
If a specific question or option keeps getting filtered (tagged) by Roblox, consider rephrasing it or changing it out completely. Roblox has extremely sensitive chat filters. To minimze filtering, try to avoid the following in your quizzes:
Excessive number use. Some here and there are generally fine, but Roblox doesn't like it when you send too many of them in a row. A question such as "What is 2+2?", with the options being: "4", "22", "10", "2" will almost certainly get filtered every time.
Names of controversial or religious figures.
Politics/world events. For example: 9/11, Donald Trump, Joe Biden, facism, etc. I'd recommend testing the filter by yourself, as Roblox does allow some historical questions (see quizzes such as WWI, WWII, Anarchy, and Cold War for examples of what Roblox does allow.