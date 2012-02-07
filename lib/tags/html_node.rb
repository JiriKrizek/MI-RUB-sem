require '../lib/invalid_tag_error.rb'
require '../lib/html_tag.rb'

module HTML
  module Tags
    class HtmlNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      # No valid attr
      def valid_attributes?
        attr.empty?
      end

      def can_has?(klass)
        valid=Set.new [HTML::Tags::HeadNode, HTML::Tags::BodyNode]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end
    end
  end
end