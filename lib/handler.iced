bot = require '../puck'
settings = require '../settings'
compile = require './hackerearth'

re = /<@[\d\w]+> (\w+)\n? ?`{1,}([\s\S]+)`{1,}/

module.exports = (user, userID, channelID, message, e) ->
	if channelID in settings.bot.channelsEnabled
		if message.startsWith "<@#{bot.id}>"
			if message.startsWith "<@#{bot.id}> languages"
				bot.sendMessage
					to: channelID
					message: "<@#{userID}> list of available languages to use with #{bot.username} \n
					C C++ C++11 Clojure C# Java JavaScript Haskell Perl PHP Python Ruby"
			else
				try
					console.log 'message', message
					data = re.exec message
					# data[1] -> language
					# data[2] -> code
					if data[1]? and data[2]?
						compile data[1], data[2], (err, result) ->
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
					console.log 'something went wrong...', e
