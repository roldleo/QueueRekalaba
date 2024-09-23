import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/queue_bloc.dart';
import '../bloc/queue_event.dart';
import '../bloc/queue_state.dart';

Widget listQueue(BuildContext context){
  return BlocBuilder<QueueBloc, QueueState>(
    builder: (context, state) {
      if (state is QueueLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is QueueLoaded) {
        final startIndex = state.currentPage * state.itemsPerPage;
        final endIndex = startIndex + state.itemsPerPage;
        final displayedQueues = state.queues.sublist(
          startIndex,
          endIndex < state.queues.length ? endIndex : state.queues.length,
        );
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text("Customer Name")),
                  DataColumn(label: Text("WhatsApp")),
                  DataColumn(label: Text("Pax")),
                  DataColumn(label: Text("Store Name")),
                  DataColumn(label: Text("Date In")),
                ],
                rows: displayedQueues.map((queue) {
                  return DataRow(cells: [
                    DataCell(Text(queue.no.toString())),
                    DataCell(Text(queue.customerName)),
                    DataCell(Text(queue.customerPhone ?? "N/A")),
                    DataCell(Text(queue.pax.toString())),
                    DataCell(Text(queue.storeName)),
                    DataCell(Text(DateTime.fromMillisecondsSinceEpoch(queue.dateIn).toString())),
                  ]);
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2 , right: MediaQuery.of(context).size.width * 0.2),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: state.currentPage > 0
                        ? () => context.read<QueueBloc>().add(PreviousPageEvent())
                        : null,
                    child: const Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: (state.currentPage + 1) * state.itemsPerPage < state.queues.length
                        ? () => context.read<QueueBloc>().add(NextPageEvent())
                        : null,
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (state is QueueError) {
        return Center(child: Text('Error: ${state.error}'));
      }
      return Container();
    },
  );
}