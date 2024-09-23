import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekalaba_test_interview/bloc/queue_event.dart';
import 'package:rekalaba_test_interview/bloc/queue_state.dart';
import '../service/api_service.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  final QueueRepository repository;

  QueueBloc(this.repository) : super(QueueInitial()) {
    on<FetchQueueEvent>((event, emit) async {
      emit(QueueLoading());
      try {
        final queues = await repository.fetchQueues();
        emit(QueueLoaded(queues: queues, currentPage: 0));
      } catch (e) {
        emit(QueueError(error: e.toString()));
      }
    });

    on<NextPageEvent>((event, emit) {
      if (state is QueueLoaded) {
        final currentState = state as QueueLoaded;
        emit(QueueLoaded(
          queues: currentState.queues,
          currentPage: currentState.currentPage + 1,
          itemsPerPage: currentState.itemsPerPage,
        ));
      }
    });

    on<PreviousPageEvent>((event, emit) {
      if (state is QueueLoaded) {
        final currentState = state as QueueLoaded;
        if (currentState.currentPage > 0) {
          emit(QueueLoaded(
            queues: currentState.queues,
            currentPage: currentState.currentPage - 1,
            itemsPerPage: currentState.itemsPerPage,
          ));
        }
      }
    });

    on<AddQueueRequested>(_onAddQueueRequested);
    on<AddQueueSuccess>(_onAddQueueSuccess);
  }
  Future<void> _onAddQueueRequested(
      AddQueueRequested event, Emitter<QueueState> emit) async {
    emit(QueueLoading());

    try {
      final message = await repository.addQueue(
          event.customerName,
          event.customerPhone,
          event.pax
      );
      emit(QueueSuccess(message));
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }

  Future<void> _onAddQueueSuccess(
      AddQueueSuccess event, Emitter<QueueState> emit) async {
    emit(QueueLoading());

    try {
      final queues = await repository.fetchSuccessQueues(event.phoneNumber);
      emit(AddQueueSuccessLoaded(addQueuesSuccess: queues));
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }
}







