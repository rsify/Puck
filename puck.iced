DiscordClient = require 'discord.io'

alias = require './lib/langAlias'
commands = require './commands'
compile = require './lib/hackerearth'
parse = require './lib/parseSource'
settings = require './settings'

bot = new DiscordClient
	autorun: true
	token: settings.bot.token

re = /<@[\d\w]+> (\w+)\n? ?`{1,}([\s\S]+?)`{1,}/
re2 = /<@[\d\w]+> (\w+)/

bot.on 'ready', ->
	console.log "#{bot.username} - (#{bot.id})"

bot.on 'message', (user, userID, channelID, message, e) ->
	
	# if channelID in settings.bot.channelsEnabled

	#hlpme
	flag = true
	if settings.bot.channelWhitelist
		flag = false
		if channelID in settings.bot.channelsEnabled
			flag = true

	if flag
		
		if message.startsWith "<@#{bot.id}>"
			match = message.match(re2)[1]
			if match of commands
				bot.sendMessage
					to: channelID
					message: "<@#{userID}>, " + commands[match]
			else
				try
					data = re.exec message
					# data[1] -> language / command
					# data[2] -> source

					language = alias data[1]
					source = parse language, data[2]

					if !language 
						bot.sendMessage
							to: channelID
							message: "<@#{userID}>, you have to specify one of these languages! \n
								`C C++ C++11 Clojure C# Java JavaScript Haskell Perl PHP Python Ruby`"
					else
						if !source
							bot.sendMessage
								to: channelID
								message: "<@#{userID}>, you have to specify some code! Remember to keep it inside of ` characters!"
						else
							compile language, source, (err, result) ->
								if err
									bot.sendMessage
										to: channelID
										message: "<@#{userID}>, something went wrong!
										``` \n
										#{err} \n
										```"
								else
									bot.sendMessage
										to: channelID
										message: "<@#{userID}>, success! Compiled in #{result.time}s \n
										Output:
										``` \n
										#{result.output} \n
										```"
				catch e
					# if e.name == 'TypeError'
					# 	bot.sendMessage
					# 		to: channelID
					# 		message: "<@#{userID}>, something went wrong, check your spelling!"

r = require('repl').start
  prompt: 'Puck> '
  useGlobal: true

r.on 'exit', ->
  console.log '\nTerminating...'
  process.exit()