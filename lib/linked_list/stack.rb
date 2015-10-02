module LinkedList
  class Stack
    attr_reader :list

    def initialize
      @list = List.build(0)
    end

    def push(value)
      list.unshift value
    end

    def pop
      list.shift
    end

    def to_s
      list.to_s
    end
    alias_method :inspect, :to_s
  end
end
