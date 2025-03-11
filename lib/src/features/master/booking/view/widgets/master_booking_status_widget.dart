import 'package:belle/src/core/core.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../../../../widgets/widgets.dart';
import '../../../../shared/shared.dart';
import '../../../master.dart';

class MasterBookingStatusWidget extends StatefulWidget {
  final String bookingId;
  final BookingStatus currentStatus;
  final VoidCallback onSuccess;

  const MasterBookingStatusWidget({
    super.key,
    required this.bookingId,
    required this.currentStatus,
    required this.onSuccess,
  });

  @override
  State<MasterBookingStatusWidget> createState() =>
      _MasterBookingStatusWidgetState();
}

class _MasterBookingStatusWidgetState extends State<MasterBookingStatusWidget> {
  final _controller = GetIt.instance<MasterBookingController>();

  Future<void> _changeStatus(BookingStatus newStatus) async {
    await _controller.changeStatus(
      widget.bookingId,
      newStatus.id,
      () {
        widget.onSuccess();
      },
    );
  }

  BookingStatus? _getNextStatus() {
    switch (widget.currentStatus) {
      case BookingStatus.waiting:
        return BookingStatus.confirmed;
      case BookingStatus.confirmed:
        return BookingStatus.clientArrived;
      case BookingStatus.clientArrived:
        return BookingStatus.completed;
      case BookingStatus.completed:
      case BookingStatus.cancelled:
      case BookingStatus.reschedule:
      case BookingStatus.notFound:
        return null;
    }
  }

  @override
  void initState() {
    _controller.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentStatus == BookingStatus.cancelled ||
        widget.currentStatus == BookingStatus.reschedule ||
        widget.currentStatus == BookingStatus.completed ||
        widget.currentStatus == BookingStatus.notFound) {
      return const SizedBox();
    }

    final nextStatus = _getNextStatus();

    if (nextStatus == null) {
      return const SizedBox();
    }

    return Observer(builder: (context) {
      return ElevatedButtonWithState(
        onPressed: () {
          // TODO: remove on release
          ShowSnackHelper.showSnack(
              context, SnackStatus.message, nextStatus.name);
          _changeStatus(nextStatus);
        },
        isLoading: _controller.stateManager.isLoading,
        child: Text(
          _getButtonText(context, nextStatus),
        ),
      );
    });
  }

  String _getButtonText(BuildContext context, BookingStatus status) {
    return context.loc.booking_status(status.name);
  }
}
