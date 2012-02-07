def b(f)
  File.dirname(__FILE__) + "/" + f
end

module HTML
  autoload :Tag, b("html_tag")
  autoload :Parser, b("parser")
  
  autoload :InvalidTokenError, b("invalid_token_error")
  autoload :InvalidTagError, b("invalid_tag_error")
  autoload :Tokenizer, b("tokenizer")
  
  module Tags
    autoload :HtmlNode, b("tags/html_node")
    autoload :UNode, b("tags/u_node.rb")
    autoload :TrNode, b("tags/tr_node.rb")
    autoload :TitleNode, b("tags/title_node.rb")
    autoload :ThNode, b("tags/th_node.rb")
    autoload :TdNode, b("tags/td_node.rb")
    autoload :TableNode, b("tags/table_node.rb")
    autoload :INode, b("tags/i_node.rb")
    autoload :HeadNode, b("tags/head_node.rb")
    autoload :H6Node, b("tags/h6_node.rb")
    autoload :H5Node, b("tags/h5_node.rb")
    autoload :H4Node, b("tags/h4_node.rb")
    autoload :H3Node, b("tags/h3_node.rb")
    autoload :H2Node, b("tags/h2_node.rb")
    autoload :H1Node, b("tags/h1_node.rb")
    autoload :HNode, b("tags/h_node.rb")
    autoload :DoctypeNode, b("tags/doctype.rb")
    autoload :BrNode, b("tags/br_node.rb")
    autoload :BodyNode, b("tags/body_node.rb")
    autoload :BNode, b("tags/b_node.rb")
    autoload :BodyLikeNode, b("tags/body_like_canhas.rb")
  end
end