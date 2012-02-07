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
    end
  end
end