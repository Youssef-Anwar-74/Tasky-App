enum TaskItemActionsEnum {
  delete(name: "Delete"),
  edit(name: "Edit");

  final String name;

  const TaskItemActionsEnum({required this.name});
}