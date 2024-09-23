import 'package:rekalaba_test_interview/model/queue_model.dart';

abstract class QueueState {}

class QueueInitial extends QueueState {}

class QueueLoading extends QueueState {}

class QueueSuccess extends QueueState {
  final String message;

  QueueSuccess(this.message);
}

class QueueLoaded extends QueueState {
  final List<Queue> queues;
  final int currentPage;
  final int itemsPerPage;

  QueueLoaded({
    required this.queues,
    this.currentPage = 0,
    this.itemsPerPage = 10,
  });
}

class AddQueueSuccessLoaded extends QueueState {
  final List<Queue> addQueuesSuccess;

  AddQueueSuccessLoaded({
    required this.addQueuesSuccess
  });
}

class QueueError extends QueueState {
  final String error;

  QueueError({required this.error});
}
