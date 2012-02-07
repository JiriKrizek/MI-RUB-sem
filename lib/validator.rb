def b(f)
  File.dirname(__FILE__) + "/" + f
end

module HTML
  autoload :Tag, b("html_tag")
  autoload :Parser, b("parser")
  
  autoload :InvalidTokenError, b("invalid_token_error")
  autoload :InvalidTagError, b("invalid_tag_error")
  autoload :InvalidChildError, b("invalid_child_error")
  autoload :Tokenizer, b("tokenizer")
  
  module Tags
    autoload :HtmlNode, b("tags/html_node")
    autoload :UNode, b("tags/u_node")
    autoload :TrNode, b("tags/tr_node")
    autoload :TitleNode, b("tags/title_node")
    autoload :ThNode, b("tags/th_node")
    autoload :TdNode, b("tags/td_node")
    autoload :TableNode, b("tags/table_node")
    autoload :INode, b("tags/i_node")
    autoload :HeadNode, b("tags/head_node")
    autoload :H6Node, b("tags/h6_node")
    autoload :H5Node, b("tags/h5_node")
    autoload :H4Node, b("tags/h4_node")
    autoload :H3Node, b("tags/h3_node")
    autoload :H2Node, b("tags/h2_node")
    autoload :H1Node, b("tags/h1_node")
    autoload :HNode, b("tags/h_node")
    autoload :DoctypeNode, b("tags/doctype")
    autoload :BrNode, b("tags/br_node")
    autoload :BodyNode, b("tags/body_node")
    autoload :BNode, b("tags/b_node")
    autoload :BodyLikeNode, b("tags/body_like_canhas")
  end
end