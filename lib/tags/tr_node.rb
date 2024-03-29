module HTML
  module Tags
    class TrNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      def valid_attributes?
        valid=Set.new ["align", "char", "valign"]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end

      def can_has?(klass)
        valid=Set.new [HTML::Tags::ThNode, HTML::Tags::TdNode]

        valid.include?(klass)
      end
    end
  end
end