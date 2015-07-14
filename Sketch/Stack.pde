class Stack<E> {
  
  ArrayList<E> stack;
  
  Stack() {
    stack = new ArrayList<E>();
  }
  
  void push(E item) {
    stack.add(item);
  }
  
  E pop() {
    return stack.remove(stack.size() - 1);
  }
  
  boolean isEmpty() {
    return (stack.size() == 0);
  }
  
}
