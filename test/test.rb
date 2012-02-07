require '../lib/parser.rb'
require '../lib/html_tag.rb'

require '../lib/tags/h1_node.rb'
require '../lib/tags/h2_node.rb'
require '../lib/tags/h3_node.rb'
require '../lib/tags/h4_node.rb'
require '../lib/tags/h5_node.rb'
require '../lib/tags/h6_node.rb'

require '../lib/tags/b_node.rb'
require '../lib/tags/i_node.rb'
require '../lib/tags/u_node.rb'
require '../lib/tags/br_node.rb'

require '../lib/tags/body_node.rb'

require '../lib/tags/table_node.rb'
require '../lib/tags/th_node.rb'
require '../lib/tags/tr_node.rb'
require '../lib/tags/td_node.rb'

require 'test/unit'

class TestTokenizer < Test::Unit::TestCase
	
	def test_html_tag
		t = HTML::Tag.new("html", Hash.new)
		assert(!t.has_attr?)

		t = HTML::Tag.new("html", {"key"=>"value"})
		assert(t.has_attr?)
	end

	def test_title_tag
		t = HTML::Tag.new("title", Hash.new)
		assert_nothing_raised(HTML::InvalidTagError) {
			HTML::Tags::TitleNode.new(t)
		}

		t = HTML::Tag.new("title", {"class"=>"kk"})
		assert_raise(HTML::InvalidTagError) {
			HTML::Tags::TitleNode.new(t)
		}		
	end

	def test_html_tag
		t = HTML::Tag.new("html", Hash.new)
		assert_nothing_raised(HTML::InvalidTagError) {
			HTML::Tags::HtmlNode.new(t)
		}

		t = HTML::Tag.new("html", {"class"=>"kk"})
		assert_raise(HTML::InvalidTagError) {
			HTML::Tags::HtmlNode.new(t)
		}		
	end

	def test_head_tag
		t = HTML::Tag.new("head", Hash.new)
		assert_nothing_raised(HTML::InvalidTagError) {
			HTML::Tags::HeadNode.new(t)
		}

		t = HTML::Tag.new("head", {"class"=>"kk"})
		assert_raise(HTML::InvalidTagError) {
			HTML::Tags::HeadNode.new(t)
		}		
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

	def test_b_tag
			cl = HTML::Tags::BNode
			tag = HTML::Tag.new("b", {})

			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("b", {"class"=>"kk", "id"=>"mm", "style"=>"cc"})
		
			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("b", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
		
			assert_raise(HTML::InvalidTagError) {
				cl.new(tag)
			}
	end

	def test_i_tag
			cl = HTML::Tags::INode
			tag = HTML::Tag.new("i", {})

			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("i", {"class"=>"kk", "id"=>"mm", "style"=>"cc"})
		
			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("i", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
		
			assert_raise(HTML::InvalidTagError) {
				cl.new(tag)
			}
	end

	def test_u_tag
			cl = HTML::Tags::UNode
			tag = HTML::Tag.new("u", {})

			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("u", {"class"=>"kk", "id"=>"mm", "style"=>"cc"})
		
			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("u", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
		
			assert_raise(HTML::InvalidTagError) {
				cl.new(tag)
			}
	end

	def test_br_tag
			cl = HTML::Tags::BrNode
			tag = HTML::Tag.new("br", {})

			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("br", {"class"=>"kk", "id"=>"mm", "style"=>"cc"})
		
			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("br", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
		
			assert_raise(HTML::InvalidTagError) {
				cl.new(tag)
			}
	end

	def test_body_tag
			cl = HTML::Tags::BodyNode
			tag = HTML::Tag.new("body", {})

			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("body", {"class"=>"kk", "id"=>"mm", "style"=>"cc"})
		
			assert_nothing_raised(HTML::InvalidTagError) {
				cl.new(tag)
			}

			tag = HTML::Tag.new("body", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
		
			assert_raise(HTML::InvalidTagError) {
				cl.new(tag)
			}
	end

	  def test_table_tag
      cl = HTML::Tags::TableNode
      tag = HTML::Tag.new("table", {})

      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("table", {"cellpadding"=>"kk", "cellspacing"=>"mm", "border"=>"cc", "summary"=>"kk"})
    
      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("table", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
    
      assert_raise(HTML::InvalidTagError) {
        cl.new(tag)
      }
  end

  def test_tr_tag
      cl = HTML::Tags::TrNode
      tag = HTML::Tag.new("tr", {})

      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("tr", {"align"=>"kk", "char"=>"mm", "valign"=>"cc"})
    
      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("tr", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
    
      assert_raise(HTML::InvalidTagError) {
        cl.new(tag)
      }
  end

  def test_th_tag
      cl = HTML::Tags::ThNode
      tag = HTML::Tag.new("th", {})

      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("th", {"abbr"=>"kk", "align"=>"mm", "rowspan"=>"cc"})
    
      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("th", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
    
      assert_raise(HTML::InvalidTagError) {
        cl.new(tag)
      }
  end

  def test_td_tag
      cl = HTML::Tags::TdNode
      tag = HTML::Tag.new("td", {})

      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("td", {"abbr"=>"kk", "align"=>"mm", "valign"=>"cc"})
    
      assert_nothing_raised(HTML::InvalidTagError) {
        cl.new(tag)
      }

      tag = HTML::Tag.new("td", {"class"=>"kk", "id"=>"mm", "neexistuje"=>"cc"})
    
      assert_raise(HTML::InvalidTagError) {
        cl.new(tag)
      }
  end

	# def test_ok_tag
	# 	parser = HTML::Parser.new
	# 	parser.string = '<html><head>
	# 									<title></title></head><body class="kk">Hello world</body></html>'
	# 	parser.parse
	# end

	# def test_invalid_tag
	# 	parser = HTML::Parser.new
	# 	parser.string = '<html><head>
	# 									#<title></kkk></head><body class="kk">Hello world</body></html>'
	# 	assert_raise(HTML::InvalidTokenError) { parser.parse }
	# end



end