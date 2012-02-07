require '../lib/tags.rb'

module HTML
  class Tag
    @@tags_map = {
        :html => "kk"
        # :html  => Tags::HtmlNode,
        # :head  => Tags::HeadNode,
        # :body  => Tags::BodyNode,
        # :title => Tags::TitleNode,
        # :b     => Tags::BNode,
        # :i     => Tags::INode,
        # :u     => Tags::UNode,
        # :br    => Tags::BrNode,
        # :h1    => Tags::H1Node,
        # :h2    => Tags::H2Node,
        # :h3    => Tags::H3Node,
        # :h4    => Tags::H4Node,
        # :h5    => Tags::H5Node,
        # :h6    => Tags::H6Node,
        # :table => Tags::TableNode,
        # :th    => Tags::ThNode,
        # :tr    => Tags::TrNode,
        # :td    => Tags::TdNode,
        # :doctype => Tags::DoctypeNode
    }

    attr_reader :tag, :attr, :ending, :tagname


    def initialize(tag, attributes)
      @tag = tag
      @attr = attributes 
      @ending = tag[0]=='/'
      
      @ending ? @tagname = tag[1..-1] : @tagname = tag
    end

    def has_attr?
      return !@attr.empty?
    end

    def can_has?(klass)
      $stderr.puts "Warning, tag does not have re-defined can_has? method"
      true
    end

    def to_s
      if has_attr?
        a=" "
        a<<@attr.to_s.chomp 
      end
      print "TAG: <#{@tag}#{a}>"
    end

    # Generic tag accepts everything
    def valid_attributes?
      true
    end

    def self.tags_map
      @@tags
    end
  end
end