import 'package:safarirally2023/services/firebase_services.dart';
import 'package:survey_kit/survey_kit.dart';

class Steps{

  static FirebaseServices firebaseServices = FirebaseServices();
  static List<TextChoice> choices = firebaseServices.stages.map((stage){
    return TextChoice(text: stage, value: stage);
  }).toList();

  static List<TextChoice> weatherChoices = ["Sunny", "Rainy", "Cloudy"].map((element){
    return TextChoice(text: element, value: element);
  }).toList();

  static List<TextChoice> groundChoices = ["Muddy", "Dusty"].map((element){
    return TextChoice(text: element, value: element);
  }).toList();



  var stageSteps = [
    InstructionStep(
      stepIdentifier: StepIdentifier(id: 'Introduction'),
      title: 'Stage Review Form',
      text: 'Please fill in the following questions after the stage ends',
      buttonText: 'Start survey',
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Stage Name'),
      text: 'Select The Stage Name',
      buttonText: "Next Question",
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: "Shakedown", value: "Shakedown"),
          TextChoice(text: "Kasarani", value: "Kasarani"),
          TextChoice(text: "Loldia", value: "Loldia"),
          TextChoice(text: "Geothermal", value: "Geothermal"),
          TextChoice(text: "Kedong", value: "Kedong"),
          TextChoice(text: "Soysambu", value: "Soysambu"),
          TextChoice(text: "Elemetaita", value: "Elementaita"),
          TextChoice(text: "Sleeping Warrior", value: "Sleeping Warrior"),
          TextChoice(text: "Malewa", value: "Malewa"),
          TextChoice(text: "Oserian", value: "Oserian"),
          TextChoice(text: "Hell's Gate", value: "Hell's Gate"),
        ]
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Ground Conditions'),
      text: 'How is the current terrain of the ground?',
      answerFormat: SingleChoiceAnswerFormat(
          textChoices: groundChoices
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Poster Presence'),
      text: 'Were posters and banners clearly depicting each zones deployed?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Poster Removal After Event'),
      text: 'Were the posters and banners removed after the event within the required time frame?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Spectator Zone Presence'),
      text: 'Was there a spectator zone in the stage?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Adequate Spectator Zone Security'),
      text: 'Was there adequate security for spectators in the spectator zone?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Adequate Posters to Guide Spectators in Spectator Zone'),
      text: 'Were there adequate signage and posters to guide spectators in the zone?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Adequate Litter Bags in Spectator Zone'),
      text: 'Were there adequate litter bags and trash bins in the area?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Cleaning In Spectator Zone'),
      text: 'Was the spectator area regularly cleaned and litter collected during the event?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Adequate Number of Toilets'),
      text: 'Were there adequate and sufficient toilets in the area?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Even Distribution of Spectator Zone Toilets'),
      text: 'Were the toilets evenly distributed between male and female?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Disabled Toilet in Spectator Zone'),
      text: 'Was there a toiled specific for the disabled?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Cleaning of Spectator Zone Toilets'),
      text: "Were the toilets cleaned regularly?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Spectator Zone Food Vendors'),
      text: "Were there food vendors in the area?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Spectator Zone Food Vendors Hygeine Compliance'),
      text: "Were the food vendors fully compliant with the food hygiene protocols",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Spectator Zone Food Vendors Proper Sanitation measures'),
      text: "Were the food vendors properly sanitized and had trash bags and litter bins?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Spectator Zone Outside Catering'),
      text: "Was there any approved outside catering in the area? (VIP)",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Spectator Zone Outside Catering Sanitation'),
      text: "Were the approved caterers properly sanitized and had trash bags and litter bins?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Spectator Zone Outside Catering Compliance'),
      text: "Were the approved caterers fully compliant with the food hygiene protocols",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    CompletionStep(
      title: 'Thank You',
      text: 'Thank you for filling this report',
      buttonText: 'Submit Report',
      stepIdentifier: StepIdentifier(id: 'Completion'),
    )
  ];

  var carWashSteps = [
    InstructionStep(
      stepIdentifier: StepIdentifier(id: 'Introduction'),
      title: 'Car Wash Review Form',
      text: 'Please fill in the following questions to track car wash sustainability efforts',
      buttonText: 'Start survey',
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Environmental Friendly Mats Present'),
      text: 'Did the carwash employ the use of environmentally friendly mats?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Car Wash Drainage Handled Properly'),
      text: 'Did the car wash ensure the drainage was channeled properly and that it was not affecting the environment?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    CompletionStep(
      title: 'Thank You',
      text: 'Thank you for filling this report',
      buttonText: 'Submit Report',
      stepIdentifier: StepIdentifier(id: 'Completion'),
    )
  ];


  var servicePackSteps = [
    InstructionStep(
      stepIdentifier: StepIdentifier(id: 'Introduction'),
      title: 'Service Park Review Form',
      text: 'Please fill in the following questions to track Service Park sustainability efforts',
      buttonText: 'Start survey',
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Adequate Toilets'),
      text: 'Were there adequate and sufficient toilets in the area?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Even Distribution of Toilets'),
      text: 'Were the toilets evenly distributed between male and female?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Disabled Toilet'),
      text: 'Was there a toiled specific for the disabled?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Cleaning of Toilets'),
      text: "Were the toilets cleaned regularly?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Adequate Lotter Bags and Trash Bins'),
      text: 'Were there adequate litter bags and trash bins in the area?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Posters'),
      text: 'Were posters and banners clearly depicting each zones deployed?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Removal of Posters After Event'),
      text: 'Were the posters and banners removed after the event within the required time frame?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Cleaning of area'),
      text: 'Was the service park area regularly cleaned and litter collected during the event?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Availability of Oil Drums'),
      text: 'Were Oil Drums available to all the crew for oil rags and oily parts?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Oil Drums Placed on Correct Surface'),
      text: "Were the oil drums placed on hard impermeable surfaces(Not on the ground)",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Oil Drums Were signed and in Convenient Location'),
      text: "Were the oil drums conveniently located and signs posted to show where they are?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Waste Disposal Bins'),
      text: "Were there waste disposal bins in the paddock area and service park?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Easy Accessibility of Waste Bins'),
      text: "Were the waste bins easily accessible and easy to find?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Proper Segregation of Waste Bins'),
      text: "Were the waste bins easily segregated into plastic, metal and general waste bins?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Collection of Solid Waste'),
      text: 'Was solid waste collected and disposed of at regular occasions i.e. litter on floor and Bins being emptied?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Collection of Hazardous Waste'),
      text: 'Was hazardous waste collected and disposed of at regular occasions i.e. oily rugs and used spill kits',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Crews using Environmental Mats and Spill Kits'),
      text: 'Were the rally crews using environmentally friendly mats and oil spill kits in the service park?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Adequate Fire Fighting Personnel and Equipment'),
      text: "Was there adequate fire fighting personnel and equipment in the area?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Outside Catering'),
      text: "Was there any approved outside catering in the area? (VIP)",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Outside Catering Observing Proper Hygiene'),
      text: "Were the approved caterers properly sanitized and had trash bags and litter bins?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Outside Catering Compliance With Food Hygeine Protocols'),
      text: "Were the approved caterers fully compliant with the food hygiene protocols",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    CompletionStep(
      title: 'Thank You',
      text: 'Thank you for filling this report',
      buttonText: 'Submit Report',
      stepIdentifier: StepIdentifier(id: 'Completion'),
    )
  ];

  var refuelSteps = [
    InstructionStep(
      stepIdentifier: StepIdentifier(id: 'Introduction'),
      title: 'Refuelling Review Form',
      text: 'Please fill in the following questions to track refuelling sustainability efforts',
      buttonText: 'Start survey',
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Poster Presence'),
      text: 'Were posters and banners clearly depicting each zones deployed?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Poster Removal After Event'),
      text: 'Were the posters and banners removed after the event within the required time frame?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Availability of Oil Drums'),
      text: 'Were Oil Drums available to all the crew for oil rags and oily parts?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Oil Drums Placed on Correct Surface'),
      text: "Were the oil drums placed on hard impermeable surfaces(Not on the ground)",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Oil Drums Were signed and in Convenient Location'),
      text: "Were the oil drums conveniently located and signs posted to show where they are?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Waste Disposal Bins'),
      text: "Were there waste disposal bins in the paddock area and service park?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Easy Accessibility of Waste Bins'),
      text: "Were the waste bins easily accessible and easy to find?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Proper Segregation of Waste Bins'),
      text: "Were the waste bins easily segregated into plastic, metal and general waste bins?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Crews using Environmental Mats and Spill Kits'),
      text: 'Were the rally crews using environmentally friendly mats and oil spill kits in the service park?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Presence of Adequate Fire Fighting Personnel and Equipment'),
      text: "Was there adequate fire fighting personnel and equipment in the area?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Adequate Toilets'),
      text: 'Were there adequate and sufficient toilets in the area?',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Cleaning of Toilets'),
      text: "Were the toilets cleaned regularly?",
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    QuestionStep(
      stepIdentifier: StepIdentifier(id: 'Regular Collection of Hazardous Waste'),
      text: 'Was hazardous waste collected and disposed of at regular occasions i.e. oily rugs and used spill kits',
      answerFormat: const BooleanAnswerFormat(
          negativeAnswer: "No",
          positiveAnswer: "Yes"
      ),
    ),
    CompletionStep(
      title: 'Thank You',
      text: 'Thank you for filling this report',
      buttonText: 'Submit Report',
      stepIdentifier: StepIdentifier(id: 'Completion'),
    )
  ];


}