import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:safarirally2023/models/steps.dart';
import 'package:safarirally2023/screens/marshall_form_screens.dart';
import 'package:safarirally2023/secrets.dart';
import 'package:safarirally2023/services/firebase_services.dart';
import 'package:survey_kit/survey_kit.dart';

import 'noise_test_form.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key, required this.report}) : super(key: key);
  final String? report;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  FirebaseServices firebaseServices = FirebaseServices();
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseServices.getUserName().then((value){
      setState(() {
        userName = value["name"];
      });
    });
  }



  @override
  Widget build(BuildContext context) {

    Steps steps = Steps();
    Secrets secrets = Secrets();

    final Map<String,dynamic> reportData = {
      "Submitted By": userName,
      "Time": DateTime.now()
    };

    var stageTask = NavigableTask(steps: steps.stageSteps, id: TaskIdentifier(id: "Stage Report"));
    var carWashTask = NavigableTask(steps: steps.carWashSteps, id: TaskIdentifier(id: "Car Wash Report"));
    var serviceParkTask = NavigableTask(steps: steps.servicePackSteps, id: TaskIdentifier(id: "Service Park Report"));
    var refuellingTask = NavigableTask(steps: steps.refuelSteps, id: TaskIdentifier(id: "Refuelling Station Report"));

    stageTask.addNavigationRule(
        forTriggerStepIdentifier: stageTask.steps[3].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return stageTask.steps[4].stepIdentifier;
                case "No":
                  return stageTask.steps[5].stepIdentifier;
              }
              return null;
            }
        )
    );
    stageTask.addNavigationRule(
        forTriggerStepIdentifier: stageTask.steps[5].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return stageTask.steps[6].stepIdentifier;
                case "No":
                  return stageTask.steps[20].stepIdentifier;
              }
              return null;
            }
        )
    );
    stageTask.addNavigationRule(
        forTriggerStepIdentifier: stageTask.steps[14].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return stageTask.steps[15].stepIdentifier;
                case "No":
                  return stageTask.steps[17].stepIdentifier;
              }
              return null;
            }
        )
    );
    stageTask.addNavigationRule(
        forTriggerStepIdentifier: stageTask.steps[17].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return stageTask.steps[18].stepIdentifier;
                case "No":
                  return stageTask.steps[20].stepIdentifier;
              }
              return null;
            }
        )
    );
    serviceParkTask.addNavigationRule(
        forTriggerStepIdentifier: serviceParkTask.steps[6].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return serviceParkTask.steps[7].stepIdentifier;
                case "No":
                  return serviceParkTask.steps[8].stepIdentifier;
              }
              return null;
            }
        )
    );
    serviceParkTask.addNavigationRule(
        forTriggerStepIdentifier: serviceParkTask.steps[9].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return serviceParkTask.steps[10].stepIdentifier;
                case "No":
                  return serviceParkTask.steps[12].stepIdentifier;
              }
              return null;
            }
        )
    );
    serviceParkTask.addNavigationRule(
        forTriggerStepIdentifier: serviceParkTask.steps[12].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return serviceParkTask.steps[13].stepIdentifier;
                case "No":
                  return serviceParkTask.steps[15].stepIdentifier;
              }
              return null;
            }
        )
    );
    serviceParkTask.addNavigationRule(
        forTriggerStepIdentifier: serviceParkTask.steps[19].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return serviceParkTask.steps[20].stepIdentifier;
                case "No":
                  return serviceParkTask.steps[22].stepIdentifier;
              }
              return null;
            }
        )
    );
    refuellingTask.addNavigationRule(
        forTriggerStepIdentifier: refuellingTask.steps[1].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return refuellingTask.steps[2].stepIdentifier;
                case "No":
                  return refuellingTask.steps[3].stepIdentifier;
              }
              return null;
            }
        )
    );
    refuellingTask.addNavigationRule(
        forTriggerStepIdentifier: refuellingTask.steps[3].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return refuellingTask.steps[4].stepIdentifier;
                case "No":
                  return refuellingTask.steps[6].stepIdentifier;
              }
              return null;
            }
        )
    );
    refuellingTask.addNavigationRule(
        forTriggerStepIdentifier: refuellingTask.steps[6].stepIdentifier,
        navigationRule: ConditionalNavigationRule(
            resultToStepIdentifierMapper: (input){
              switch (input) {
                case "Yes":
                  return refuellingTask.steps[7].stepIdentifier;
                case "No":
                  return refuellingTask.steps[9].stepIdentifier;
              }
              return null;
            }
        )
    );



    Task getTasks(){
      if(widget.report == "Stage Reports"){
        return stageTask;
      }
      else if (widget.report == "Car Wash Reports"){
        return carWashTask;
      }
      else if (widget.report == "Refuelling Reports"){
        return refuellingTask;
      }
      else{
        return serviceParkTask;
      }
    }

    sendNotificationToAdmin() async {
      //Our API Key
      var serverKey = secrets.apiKey;

      //Get our Admin token from Firesetore DB
      var token = [];
      await firebaseServices.getUsers().then((value){
        for(var item in value.docs){
          token.add(item.get("token"));
        }
      });

      //Create Message with Notification Payload
      String constructFCMPayload(String token) {
        return jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "$userName submitted a new report into ${widget.report}",
              'title': "Update to ${widget.report}",
            },
            'data': <String, dynamic>{

            },
            'to': token
          },
        );
      }

      for (var item in token){
        if (item.isEmpty) {
          return log('Unable to send FCM message, no token exists.');
        }
        try {
          //Send  Message
          http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'key=$serverKey',
              },
              body: constructFCMPayload(item));

          log("status: ${response.statusCode} | Message Sent Successfully!");
        } catch (e) {
          log("error push notification $e");
        }
      }
    }


    Widget formReturn(){
      if(widget.report != "Noise Test Reports"){
        return SurveyKit(
            task: getTasks(),
            themeData: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              scaffoldBackgroundColor: Colors.yellowAccent,
              fontFamily: "Lato",
              useMaterial3: true,
            ),
            onResult: (result){
              final jsonResult = result.results;
              // print the json-formatted results

              if(widget.report == "Stage Reports"){
                for (var result in jsonResult){
                  reportData.addEntries({
                    result.results[0].id!.id: result.results[0].valueIdentifier.toString()
                  }.entries);
                }

                firebaseServices.addStageReport(widget.report, reportData).then((value){
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    screen: const MarshallForms(),
                    withNavBar: false,
                    settings: const RouteSettings(name: MarshallForms.id),
                  );
                  sendNotificationToAdmin();
                });
              } else {
                for (var result in jsonResult){
                  reportData.addEntries({
                    result.results[0].id!.id: result.results[0].valueIdentifier.toString()
                  }.entries);
                }


                firebaseServices.addOtherReport(widget.report, reportData).then((value){
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    screen: const MarshallForms(),
                    withNavBar: false,
                    settings: const RouteSettings(name: MarshallForms.id),
                  );
                  sendNotificationToAdmin();
                });
              }
            }
        );
      }
      else{
        return const NoiseTestForm();
      }
    }


    return Scaffold(
      body: formReturn(),
    );
  }
}
