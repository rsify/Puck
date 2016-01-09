request = require 'request'
settings = require '../settings.iced'

ENDPOINT = 'https://api.hackerearth.com/v3/code/run/'

module.exports = (lang, source, callback) ->

	data =
		client_secret: settings.hackerEarth.clientSecret
		async: 0
		source: source
		lang: lang

	request
		url: ENDPOINT
		method: 'POST'
		form: data
		gzip: true
	, (err, response, body) ->
		body = JSON.parse(body)
		if body.compile_status == 'OK'
			callback null,
				output: body.run_status.output
				time: body.run_status.time_used
		else
			callback body.compile_status, null