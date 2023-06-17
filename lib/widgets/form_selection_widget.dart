import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:safarirally2023/screens/marshall_form.dart';
import 'package:safarirally2023/services/firebase_services.dart';

class FormSelectionWidget extends StatefulWidget {
  const FormSelectionWidget({Key? key}) : super(key: key);

  @override
  State<FormSelectionWidget> createState() => _FormSelectionWidgetState();
}

class _FormSelectionWidgetState extends State<FormSelectionWidget> {
  @override
  Widget build(BuildContext context) {

    final FirebaseServices firebaseServices = FirebaseServices();

    return StreamBuilder<QuerySnapshot>(
        stream: firebaseServices.getForms(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){


          if(!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator()),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.docs.map((DocumentSnapshot document){
                      return InkWell(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                            context,
                            screen: MarshallForm(report: document.id,),
                            withNavBar: false,
                            settings: const RouteSettings(name: MarshallForm.id),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: Card(
                                      elevation: 8,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4.0),
                                        child: Image.network(
                                          document["url"],
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Text(
                                    document.id,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Anton"
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}