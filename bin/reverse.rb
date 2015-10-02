$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'linked_list'

include LinkedList

list = List.build(5, 0) # => { 0, 0, 0, 0, 0 }

list.at(1) # => 0
list.at(2, 4) # => 4
list.at(3, 9) # => 9
list.at(5, 1111) # => 1111
list # => { 0, 4, 9, 0, 1111 }

list.unshift(1) # => { 1, 0, 4, 9, 0, 1111 }
list.shift # => 1
list # => { 0, 4, 9, 0, 1111 }

stack = Stack.new # => {  }
stack.push 3 # => { 3 }
stack.push 4 # => { 4, 3 }
