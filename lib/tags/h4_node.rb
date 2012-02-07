require '../lib/invalid_tag_error.rb'
require '../lib/tags/h_node.rb'
require 'set'

module HTML
  module Tags
    class H4Node < HTML::Tags::HNode
      def initialize(tag)
        super(tag)
      end
    end
  end
end