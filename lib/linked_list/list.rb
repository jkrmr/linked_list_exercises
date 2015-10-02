module LinkedList
  class List
    attr_accessor :head, :curr, :curr_index, :length

    # @param [Integer] length - the desired length of the list
    #
    # @return [List] a linked list of length `length`
    def self.build(length)
      fail ArgumentError, 'negative list length' if length < 0

      List.new.tap do |list|
        list.length = length
        list.head = LinkedList::Node.build_links(length) { block_given? ? yield : nil }
      end
    end

    # alias for #at getter
    def [](index)
      at(index)
    end

    # alias for #at setter
    def []=(index, value)
      at(index, value)
    end

    # append to the list
    def unshift(value)
      new_head = Node.new(value: value, next_node: head)
      increment_length!
      self.head = new_head
      self
    end

    # remove head node, returning its value
    def shift
      value = head.value
      delete_at(1)
      value
    end

    # deletes the node at position `posn`
    def delete_at(posn)
      if posn == 1
        remove_head
      elsif posn == length
        remove_last
      else
        remove_intermediate(posn)
      end

      decrement_length!
      self
    end

    # collects nodes, or the response from a message-send to the nodes, in the
    # passed-in `collection`
    def collect_nodes(collection:, node_message: nil)
      each { |node| collection << response_or_receiver(node, node_message) }
      collection
    end

    # iterates through the linked list, yielding each node in turn
    def each
      reset_and_return_nil do
        loop do
          yield(curr, curr_index)
          next!

          break if curr_index > length
        end
      end
    end

    # Sets the value of the node at position `position` when passed `set_value`,
    # else gets the value of the node at position `position`.
    #
    # @param [Integer] position - the 1-indexed list position of interest
    # @param [Object] set_value - value to set the node at position `position`
    #
    # @return [Object] the value at position `position`
    def at(position, set_value = nil)
      fail ArgumentError, 'invalid position' unless position.between?(1, length)

      return get(position) if set_value.nil?

      set(position, set_value)
    end

    # Reverses the list by building a list of equivalent length and populating
    # it with the values of `self` in reverse order. Does not attempt to be
    # efficient. Operates in quadratic time.
    def reverse
      List.build(length).tap do |reversed_list|
        each do |node, idx|
          rtl_posn = length - idx.pred
          reversed_list[rtl_posn] = node.value
        end
      end
    end

    # Reverses the linked list in place
    def reverse!
      return self if length.zero?

      prev = nil
      curr = head

      until curr.nil?
        # next will be curr's successor
        nxt = curr.next_node

        # reverse: set curr's successor to the previous node
        curr.next_node = prev

        # new previous ptr points to curr
        prev = curr

        # advance curr ptr to curr's successor
        curr = nxt
      end

      head.next_node = nil
      self.head = prev

      self
    end

    def to_s
      elements = collect_nodes(collection: [], node_message: :to_s).join(', ')
      "{ #{elements} }"
    end
    alias_method :inspect, :to_s

    private

    def initialize
      @length = 0
    end

    def get(posn)
      traverse(to_posn: posn) { |node| return node.value }
    end

    def set(posn, set_value)
      traverse(to_posn: posn) { |node| return node.value = set_value }
    end

    def next_node
      return if curr.nil?
      curr.next_node
    end

    # advances the curr pointer to the next node in the list
    # increments the curr index by 1
    def next!
      self.curr = curr.next_node
      self.curr_index = curr_index.succ
    end

    # resets the curr pointer to the head of the list
    def reset!
      self.curr = head
      self.curr_index = 1
    end

    # decrements the length of the list by 1
    def decrement_length!
      self.length = length.pred
    end

    # increments the length of the list by 1
    def increment_length!
      self.length = length.succ
    end

    # returns the response from a message-send from the receiver, or, if no
    # message is passed, the receiver itself
    def response_or_receiver(receiver, message = nil)
      return receiver if message.nil?

      receiver.send(message)
    end

    # traverses the linked list to the requested 1-indexed position and yields
    # that node to the client
    def traverse(to_posn:)
      reset_and_return_nil do
        next! until curr_index == to_posn
        yield(curr) if block_given?
      end
    end

    # wraps yielded-to block with `curr` pointer resets and returns nil
    def reset_and_return_nil
      return if length == 0
      reset!
      yield if block_given?
      reset!
      nil
    end

    def remove_intermediate(posn)
      traverse(to_posn: posn.pred) do |prev_node|
        deleted = prev_node.next_node
        prev_node.next_node = deleted.next_node
      end
    end

    def remove_last
      traverse(to_posn: length.pred) do |penultimate_node|
        penultimate_node.next_node = nil
      end
    end

    def remove_head
      self.head = head.next_node
    end
  end
end
