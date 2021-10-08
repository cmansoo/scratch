class Node:
    def __init__(self, data):
        self.data = data
        self.next = None


class Linked_list:
    def __init__(self):
        self.head = None

    def print_list(self):
        temp = self.head
        while temp:
            print(temp.data)
            temp = temp.next


def main():
    linked_list = Linked_list()

    linked_list.head = Node(1)
    second = Node(2)
    third = Node(3)

    linked_list.head.next = second
    second.next = third

    linked_list.print_list()


if __name__ == '__main__':
    main()
