import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../services/firebase_services.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Crew Reports"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: services.reports.orderBy("time", descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.size == 0) {
            return const Center(
              child: Text("Nothing to report yet"),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(32),
                              child: Row(
                                children: [
                                  Expanded(
                                    /*1*/
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            document["submitted by"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "At ${document["time"].toDate().toString()}",
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        Text(
                                          "Area: ${document["area"]}",
                                          style: TextStyle(
                                            color: Colors.red[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                document["comment"],
                                softWrap: true,
                              ),
                            ),
                            SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Flexible(child: WidgetZoom(heroAnimationTag: "Picture", zoomWidget: Image.network(document["image"], fit: BoxFit.fill, width: MediaQuery.of(context).size.width,)))
                                ],
                              )
                            ),
                            const SizedBox(height: 15,),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}
