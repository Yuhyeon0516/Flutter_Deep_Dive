class RouteName {
  RouteName._();

  static RouteName routeName = RouteName._();

  factory RouteName() {
    return routeName;
  }

  static const String homeScreen = 'home_screen';
  static const String addAndUpdateTodoScreen = 'add_and_update_todo_screen';
}
