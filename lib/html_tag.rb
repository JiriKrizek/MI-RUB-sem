module HTML
  class Tag
    attr_reader :tag, :attr, :ending

    def initialize(tag, attributes)
      @tag = tag
      @attr = attributes 
      @ending = tag[0]=='/'
    end

    def has_attr?
      return !@attr.empty?
    end

    def to_s
      if has_attr?
        a=" "
        a<<@attr.to_s.chomp 
      end
      print "<#{@tag}#{a}>"
    end
  end
end