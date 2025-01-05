# renda_assessment_app

Setup and Installation
-
1. Install Dependencies: flutter pub get
2. Run the App: flutter run


Architectural approach : The application follows the Model-View-ViewModel (MVVM) architecture, 
which promotes a clear separation of concerns, making the code more modular, testable, and scalable.
State management :Flutter Riverpod inline with riverpod annotation
Local storage : Shared preference was used effectively throughout the app for storing of data locally.

Other packages Used:

google_fonts: a fonts api provider
flutter_animate: for smooth animations in the application
flutter_svg: for displaying SVG assets properly
riverpod_annotation: offers a simpler syntax for the riverpod provider by relying on code generation 
dotted_line
flutter_screenutil for managing media queries in a detailed way
skeletonizer: for managing loading state on the pages to give the pages a smooth transition once the data is fetched 
http: Future-based library for making HTTP client requests


📂 PROJECT STRUCTURE
- 
lib/
├── models/         # Data Models
├── presentation    # UI Screens and components
├── providers/      # Business Logic and view logic(view models),API Services
├── res/            # Constants 
├── utils/          # Utilities functions and extensions 
├── src/            # barrel files for export
└── app.dart        # Sub-Entry Point
└── main.dart       # Entry Point

ADDITIONAL FEATURES
- the app handles bad network connection by popping up a dialogue that prompts user about the network 
  issue and provides user with a button to retry connection

STEPS AND FUNCTIONS
- 
- search delivery list for specific delivery 
- tap on item in list to preview the delivery from a bottom sheet
- tap the CTA button in the bottom sheet to see full details of delivery 
- tap the more button on the app bar to change the status of delivery .

