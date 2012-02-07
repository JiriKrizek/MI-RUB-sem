module HTML
  class Tag
    attr_reader :tag, :attr, :ending, :tagname

    def initialize(tag, attributes)
      @tag = tag
      @attr = attributes 
      @ending = tag[0]=='/'
      
      @ending ? @tagname = tag[1..-1] : @tagname = tag
    end

    def has_attr?
      return !@attr.empty?
    end

    def to_s
      if has_attr?
        a=" "
        a<<@attr.to_s.chomp 
      end
      print "TAG: <#{@tag}#{a}>"
    end

    # Generic tag accepts everything
    def valid_attributes?
      true
    end
  end
end