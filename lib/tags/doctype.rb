module HTML
  module Tags
    class DoctypeNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      def valid_attributes?
        true
      end

      def can_has?(klass)
        valid=Set.new [HTML::Tags::HtmlNode]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end
    end
  end
end