import 'package:flutter/material.dart';
import 'package:rekalaba_test_interview/model/queue_model.dart';

Widget cardSuccess(BuildContext context, List<Queue> queue){
  DateTime currentTime = DateTime.now();
  return Flexible(
    child: ListView.builder(
        itemCount: queue.length,
      itemBuilder: (context, index){
        final data = queue[index];
          return Container(
            padding: const EdgeInsets.all(20),
            margin:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.2, right:MediaQuery.of(context).size.width * 0.2),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            keyValue('No Antrian', data.no.toString()),
                            keyValue('Customer', data.customerName),
                            keyValue('Avg Waktu Tunggu', '-'),
                          ],
                        )
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        keyValue('Store Name', data.storeName),
                        keyValue('Pax', data.pax.toString()),
                        keyValue('Jam Submit', '${currentTime.hour}:${currentTime.minute}'),
                      ],)
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estimasi Waktu Masuk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Text('-', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          );
      }

    ),
  );
}

Widget keyValue(String key, String value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(key, style: TextStyle(color: Colors.white),),
      Text(value, style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold),)
    ],
  );
}