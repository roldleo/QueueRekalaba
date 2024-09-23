abstract class QueueEvent {}

class FetchQueueEvent extends QueueEvent {}

class NextPageEvent extends QueueEvent {}

class PreviousPageEvent extends QueueEvent {}

class AddQueueRequested extends QueueEvent {
  final String customerName;
  final String? customerPhone;
  final int pax;

  AddQueueRequested(this.customerName, this.customerPhone, this.pax);

}

class AddQueueSuccess extends QueueEvent {
  final String phoneNumber;
  AddQueueSuccess(this.phoneNumber);
}