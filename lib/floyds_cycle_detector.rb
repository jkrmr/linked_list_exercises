module FloydsCycleDetector
  class << self
    def infinite?(list)
      hare = tortoise = list.head

      loop do
        return false if hare.next_node.nil?
        hare = hare.next_node

        return false if hare.next_node.nil?
        hare = hare.next_node
        tortoise = tortoise.next_node

        return true if hare == tortoise
      end
    end
  end
end
