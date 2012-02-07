require '../lib/invalid_tag_error.rb'

module HTML
  module Tags
    class ThNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      def valid_attributes?
        valid=Set.new ["abbr", "align", "rowspan"]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end

      def can_has?(klass)
        false
      end
    end
  end
end