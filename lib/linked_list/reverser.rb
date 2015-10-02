module LinkedList
  def self.reverse(list, using_collection:)
    list.collect_nodes(collection: using_collection, node_message: :value)
  end

  def self.reverse!(list)
    list.reverse!
  end
end
