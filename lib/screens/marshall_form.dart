import 'package:flutter/material.dart';
import 'package:safarirally2023/widgets/form_widget.dart';

class MarshallForm extends StatefulWidget {
  static const String id = 'marshall-form';
  const MarshallForm({Key? key, this.report}) : super(key: key);
  final String? report;


  @override
  State<MarshallForm> createState() => _MarshallFormState();
}

class _MarshallFormState extends State<MarshallForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FormWidget(report: widget.report,),
    );
  }
}
