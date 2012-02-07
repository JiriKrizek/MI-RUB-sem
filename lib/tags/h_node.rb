require 'set'

module HTML
  module Tags
    class HNode < Tag
      def initialize(tag)
        super(tag.tag, tag.attr)
        fail HTML::InvalidTagError.new("Invalid attributes in tag #{@tag}") unless valid_attributes? 
      end
      
      def valid_attributes?
        valid=Set.new ["class","id","lang"]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end
    end
  end
end