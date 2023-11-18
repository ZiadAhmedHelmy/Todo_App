abstract class noteStates{}
class intiNoteState extends noteStates{}

// functions on Task

class ChangeIndexState extends noteStates{}



// GetTasks
class GetTasksLoadingState extends noteStates{}
class GetTasksSuccessState extends noteStates{}
class GetTasksErrorState extends noteStates{}



// Task Function
class AddTaskLoadingState extends noteStates{}
class AddTaskSuccessState extends noteStates{}
class AddTaskErrorState extends noteStates{}

// UpDate Task
class UpDateTaskLoadingState extends noteStates{}
class UpDateTaskSuccessState extends noteStates{}
class UpDateTaskErrorState extends noteStates{}


// Delete Task
class DeleteTaskLoadingState extends noteStates{}
class DeleteTaskSuccessState extends noteStates{}
class DeleteTaskErrorState extends noteStates{}


// Changing Status
class ChangingStatusState extends noteStates{}


// SelectIamge
class UpLoadImageLoadingState extends noteStates{}
class UpLoadImageSuccessState extends noteStates{}
class UpLoadImageErrorState extends noteStates{}

// Statistics
class StatisticsLoadingState extends noteStates{}
class StatisticsSuccessState extends noteStates{}
class StatisticsErrorState extends noteStates{}


// fetch Tasks for Pagination
class FetchTasksLoadingState extends noteStates{}
class FetchTasksSuccessState extends noteStates{}
class FetchTasksErrorState extends noteStates{}





