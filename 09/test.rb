require_relative 'doubly_linked_list'

# work the kinks out of my doubly linked list

list = DoublyLinkedList.new(0)
for i in 1..5
  list.add_right_node(i)
end
puts list.string
list.rotate_cw(2)
puts "rotate cw 2"
puts list.string
list.delete_current
puts "delete current"
puts list.string
