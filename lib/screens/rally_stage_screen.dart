import 'package:flutter/material.dart';
import 'package:safarirally2023/widgets/map_widget.dart';

class RallyStageScreen extends StatefulWidget {
  static const String id = "rally-stage-screen";
  const RallyStageScreen({Key? key, required this.documentId}) : super(key: key);
  final String? documentId;

  @override
  State<RallyStageScreen> createState() => _RallyStageScreenState();
}

class _RallyStageScreenState extends State<RallyStageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: RallyStageMap(stage: widget.documentId.toString(),)
            ),
          ],
        ),
      ),
    );
  }
}
