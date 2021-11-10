class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
        
    def __repr__(self):
        return self.data
    

class Linked_list:
    def __init__(self):
        self.head = None

    def __repr__(self):
        node = self.head
        nodes = []
        while node is not None:
            nodes.append(node.data)
            node = node.next
        nodes.append('None')
        return ' -> '.join(nodes)


def main():
    linked_list = Linked_list()

    linked_list.head = Node(1)
    second = Node(2)
    third = Node(3)

    linked_list.head.next = second
    second.next = third

    print(linked_list)


if __name__ == '__main__':
    main()
