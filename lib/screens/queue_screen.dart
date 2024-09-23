import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekalaba_test_interview/widgets/queue_forms_widget.dart';
import 'package:rekalaba_test_interview/widgets/queue_list.dart';
import '../bloc/queue_bloc.dart';
import '../bloc/queue_event.dart';


class QueueListScreen extends StatefulWidget {
  const QueueListScreen({super.key});

  @override
  _QueueListScreenState createState() => _QueueListScreenState();
}

class _QueueListScreenState  extends State<QueueListScreen> {

  @override
  void initState() {
    super.initState();
    context.read<QueueBloc>().add(FetchQueueEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Queue List")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Create a Queue', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
              addQueueForm(context),
              const SizedBox(
                height: 60,
              ),
              listQueue(context),
            ],
          ),
        ),
      ),
    );
  }
}

