require '../lib/invalid_tag_error.rb'
require '../lib/tags/body_like_canhas.rb'

module HTML
  module Tags
    class BNode < BodyLikeNode
      def valid_attributes?
        valid=Set.new ["class", "id", "style"]

        @attr.each {|key, value|
          return false unless valid.include?(key)
        }
        true
      end

      def can_has?(klass)
        self.can_has?(klass)
      end
    end
  end
end