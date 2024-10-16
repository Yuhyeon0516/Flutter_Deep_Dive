class StringHelper {
  StringHelper._();

  static final StringHelper stringHelper = StringHelper._();

  factory StringHelper() {
    return stringHelper;
  }

  static const String todoApp = 'Todo App';
  static const String sorryThingWentWrong = 'Sorry thing went wrong';
  static const String all = 'All';
  static const String todo = 'Todo';
  static const String addTodo = 'Add Todo';
  static const String updateTodo = 'Update Todo';
  static const String done = 'Done';
}
