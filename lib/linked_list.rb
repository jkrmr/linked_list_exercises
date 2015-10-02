module LinkedList
  # models a single node in a linear linked list
  class Node; end

  # implements the linear linked list adt
  class List; end

  # implements the stack adt using a linear linked list
  class Stack; end

  class << self
    # reverse the given list non-destructively
    def reverse(list, using_collection:)
      list.collect_nodes(collection: using_collection, node_message: :value)
    end

    # reverse the given list in-place
    def reverse!(list)
      list.reverse!
    end
  end
end

require 'linked_list/node'
require 'linked_list/list'
require 'linked_list/stack'
