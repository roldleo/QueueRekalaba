import 'package:flutter/material.dart';
import 'package:rekalaba_test_interview/model/queue_model.dart';
import 'package:rekalaba_test_interview/widgets/queue_success_widget.dart';


class AddQueueSuccessScreen extends StatelessWidget {
  final List<Queue> queue;
  const AddQueueSuccessScreen({
    super.key,
    required this.queue
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Queue'),
      ),
      body: Column(
        children: [
         cardSuccess(context, queue),
        ],
      ) ,
    );
  }
}
