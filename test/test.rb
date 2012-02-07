require '../lib/parser.rb'
require '../lib/html_tag.rb'
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


	def test_html_tag
		t = HTML::Tag.new("html", Hash.new)
		assert(!t.has_attr?)

		t = HTML::Tag.new("html", {"key"=>"value"})
		assert(t.has_attr?)
	end

end