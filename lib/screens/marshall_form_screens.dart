import 'package:flutter/material.dart';
import 'package:safarirally2023/widgets/form_selection_widget.dart';


class MarshallForms extends StatefulWidget {
  static const String id = "marshall-forms";
  const MarshallForms({Key? key}) : super(key: key);

  @override
  State<MarshallForms> createState() => _MarshallFormsState();
}

class _MarshallFormsState extends State<MarshallForms> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                        height: 30,
                        child: Image.asset("images/map2.gif", fit: BoxFit.cover,)
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Rally Report Forms",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Pick the Sector you want to fill the report on",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontFamily: "sans-serif-light",
                      fontSize: 16
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const SizedBox(
                  height: 250,
                  child: FormSelectionWidget()
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
