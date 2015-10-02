$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'linked_list'

include LinkedList

list = List.build(5) { rand(10) } # => 
stack = Stack.new # => 

LinkedList.reverse(list, using_collection: stack) # => 
