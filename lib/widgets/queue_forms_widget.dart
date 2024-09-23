import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/queue_event.dart';
import '../bloc/queue_bloc.dart';
import '../bloc/queue_state.dart';

Widget addQueueForm(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController paxController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: phoneController,
          decoration: const InputDecoration(labelText: 'WhatsApp Number'),
        ),
        TextField(
          controller: paxController,
          decoration: const InputDecoration(labelText: 'Total Pax'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final String name = nameController.text;
            final String? phone = phoneController.text.isNotEmpty ? phoneController.text : null;
            final int pax = int.tryParse(paxController.text) ?? 0;

            if (name.isNotEmpty && pax > 0) {
              context.read<QueueBloc>().add(AddQueueRequested(name, phone, pax));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Name and Number of Pax must be filled in')),
              );
            }
          },
          child: const Text('Create Queue'),
        ),
        BlocListener<QueueBloc, QueueState>(
          listener: (context, state) {
            if (state is QueueSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              print('Phone Number : ${phoneController.text}');
              context.read<QueueBloc>().add(AddQueueSuccess(phoneController.text));
            } else if (state is AddQueueSuccessLoaded) {
              Navigator.of(context).pushNamed('/newQueue', arguments: state.addQueuesSuccess);
            }else if (state is QueueError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: const SizedBox.shrink(),
        ),
      ],
    ),
  );
}
