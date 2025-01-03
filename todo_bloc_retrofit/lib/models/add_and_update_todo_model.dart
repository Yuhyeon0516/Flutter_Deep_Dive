class AddAndUpdateTodoModel {
  String? title;
  String? description;
  bool? isCompleted;

  AddAndUpdateTodoModel({this.title, this.description, this.isCompleted});

  AddAndUpdateTodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    return data;
  }
}
