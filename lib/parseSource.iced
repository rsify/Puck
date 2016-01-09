module.exports = (language, source) -> 
	if language is 'JAVASCRIPT'
		# dirty hacks lol
		source = source.replace(/console\.log/g, 'print')

	source