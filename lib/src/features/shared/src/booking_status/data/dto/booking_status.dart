enum BookingStatus {
  notFound(0),
  cancelled(2),
  confirmed(1),
  waiting(3),
  completed(4),
  reschedule(5),
  clientArrived(6);

  final int id;

  const BookingStatus(this.id);

  factory BookingStatus.fromJson(int? statusId) {
    switch (statusId) {
      case 1:
        return BookingStatus.confirmed;
      case 2:
        return BookingStatus.cancelled;
      case 3:
        return BookingStatus.waiting;
      case 4:
        return BookingStatus.completed;
      case 5:
        return BookingStatus.reschedule;
      case 6:
        return BookingStatus.clientArrived;
      default:
        return BookingStatus.notFound;
    }
  }

  int toJson() => id;
}
