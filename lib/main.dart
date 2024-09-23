import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekalaba_test_interview/screens/add_queue_success_screen.dart';
import 'package:rekalaba_test_interview/screens/queue_screen.dart';
import 'package:rekalaba_test_interview/service/api_service.dart';
import 'package:rekalaba_test_interview/model/queue_model.dart';
import 'bloc/queue_bloc.dart';
import 'bloc/queue_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => QueueBloc(QueueRepository()),
          ),
        ],

        child: MaterialApp(
          title: 'RekaLaba',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/' :(context) => const QueueListScreen(),
            '/newQueue': (context) {
              final queues = ModalRoute.of(context)!.settings.arguments as List<Queue>;
              return AddQueueSuccessScreen(queue: queues);
            },
        },
        )
      );
  }
}
