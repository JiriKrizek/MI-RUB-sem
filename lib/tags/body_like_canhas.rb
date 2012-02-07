module HTML
  module Tags
    class BodyLikeNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      def can_has?(klass)
        valid=Set.new [HTML::Tags::BNode,
                      HTML::Tags::INode,
                      HTML::Tags::UNode,
                      HTML::Tags::BrNode,
                      HTML::Tags::TableNode,
                      HTML::Tags::H1Node,
                      HTML::Tags::H2Node,
                      HTML::Tags::H3Node,
                      HTML::Tags::H4Node,
                      HTML::Tags::H5Node,
                      HTML::Tags::H6Node]

        valid.include?(klass)
      end
    end
  end 
end