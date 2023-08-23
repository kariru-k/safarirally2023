import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:safarirally2023/widgets/form_selection_widget.dart';

import 'reporting_tool.dart';


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
                        child: Image.asset("images/the-form.gif", fit: BoxFit.cover,)
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
              const SizedBox(height: 30,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                        height: 30,
                        child: Image.asset("images/report_gif.gif", fit: BoxFit.cover,)
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Real-Time Reports",
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
                  "Use this when raising an issue or a comment",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontFamily: "sans-serif-light",
                      fontSize: 16
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: InkWell(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      screen: const ReportingTool(),
                      withNavBar: false,
                      settings: const RouteSettings(name: ReportingTool.id),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                elevation: 8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image.asset(
                                    "images/report.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                            child: Text(
                              "Real Time Reporting Tool",
                              style: TextStyle(
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
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
