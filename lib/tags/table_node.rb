require '../lib/invalid_tag_error.rb'

module HTML
  module Tags
    class TableNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      def valid_attributes?
        valid=Set.new ["border", "cellpadding", "cellspacing", "summary"]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end
    end
  end
end