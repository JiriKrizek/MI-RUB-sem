require '../lib/parser.rb'
require '../lib/html_tag.rb'
require '../lib/tags/h1_node.rb'
require '../lib/tags/h2_node.rb'
require '../lib/tags/h3_node.rb'
require '../lib/tags/h4_node.rb'
require '../lib/tags/h5_node.rb'
require '../lib/tags/h6_node.rb'
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
										#<title></kkk></head><body class="kk">Hello world</body></html>'
		assert_raise(HTML::InvalidTokenError) { parser.parse }
	end


	def test_html_tag
		t = HTML::Tag.new("html", Hash.new)
		assert(!t.has_attr?)

		t = HTML::Tag.new("html", {"key"=>"value"})
		assert(t.has_attr?)
	end

	def test_h_tags
		[HTML::Tags::H1Node, HTML::Tags::H2Node, HTML::Tags::H3Node, 
		HTML::Tags::H4Node, HTML::Tags::H5Node, HTML::Tags::H6Node].each do |cl|
			tag = HTML::Tag.new("h", {"clas"=>"kk"})

			assert_raise(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("h", {"class"=>"kk", "id"=>"mm", "lang"=>"cc"})
		
			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}
		end
	end

end