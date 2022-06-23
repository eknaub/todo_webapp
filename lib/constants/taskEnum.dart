enum TaskEnum { taskIdx, taskSteps, taskCurrentSteps, taskDescription }

extension TaskEnumExtension on TaskEnum {
  int get id {
    switch (this) {
      case TaskEnum.taskIdx:
        return 0;
      case TaskEnum.taskSteps:
        return 1;
      case TaskEnum.taskCurrentSteps:
        return 2;
      case TaskEnum.taskDescription:
        return 3;
      default:
        return -1;
    }
  }
}
