require '../lib/parser.rb'
require 'test/unit'

class TestTokenizer < Test::Unit::TestCase
	def test_ok_tag
		parser = HTML::Parser.new
		parser.string = '<html><head>
										<title></title></head><body class="kk">Hello world</body></html>'
		parser.parse
	end

	def test_invalid_tag
		parser = HTML::Parser.new
		parser.string = '<html><head>
										<title></kkk></head><body class="kk">Hello world</body></html>'
		assert_raise(HTML::InvalidTokenError) { parser.parse }
	end
end