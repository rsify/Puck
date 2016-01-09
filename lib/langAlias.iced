aliases =
	'c': 'C'
	'c++': 'CPP'
	'c++11': 'CPP11'
	'clojure': 'CLOJURE'
	'c#': 'CSHARP'
	'java': 'JAVA'
	'javascript': 'JAVASCRIPT'
	'js': 'JAVASCRIPT'
	'haskell': 'HASKELL'
	'perl': 'PERL'
	'php': 'PHP'
	'python': 'PYTHON'
	'ruby': 'RUBY'

module.exports = (name) => aliases[name.toLowerCase()]