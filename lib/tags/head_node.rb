module HTML
  module Tags
    class HeadNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      # No valid attr
      def valid_attributes?
        attr.empty?
      end

      def can_has?(klass)
        valid=Set.new [HTML::Tags::TitleNode]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end
    end
  end
end