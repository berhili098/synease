# Syndease Project

Syndease project created in flutter using GetX and Firebase. Syndease supports both ios and android, clone the appropriate branches mentioned below:

* For Mobile: <https://github.com/ladron099/syndease/tree/main> (stable channel)

## Getting Started

The project designed to help solve syndic problems and make life easier for renters! Our this app designed to simplify the rental process for both landlords and tenants.
With this app, landlords can easily communicate with their syndic and stay up-to-date on any issues related to their rental property. They can also track maintenance requests and repairs, ensuring that everything is taken care of in a timely and efficient manner.
For renters, this app offers a user-friendly interface that allows them to quickly report any issues or problems with their rental unit. They can also easily communicate with their landlord or property manager, making it easier to get the help they need when they need it.
Overall, this app is designed to make the rental process smoother and more efficient for everyone involved.

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/ladron099/synease
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Hide Generated Files

In-order to hide generated files, navigate to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines under `ignore files and folders` section:

```
*.inject.summary;*.inject.dart;*.g.dart;
```

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add the following patterns:

```
**/*.inject.summary
**/*.inject.dart
**/*.g.dart
```

## App Features

* Splash
* Login
* Home
* Database
* Getx (State Management)
* Validation
* Code Generation
* User Notifications
* Logging
* Dependency Injection
* Multilingual Support

### Libraries & Tools Used

* [cloud_firestore](https://pub.dev/packages/cloud_firestore/install)
* [easy_localization](https://pub.dev/packages/easy_localization/install)
* [getX](https://pub.dev/packages/get/install)
* [Session manager](https://pub.dev/packages/flutter_session_manager)

### Folder Structure

Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- controllers/
|- screens/
|- utils/
|- models/ 
|- main.dart 
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- app_vars - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `colors`, `dimentions`, and `strings`.  
2- screens — Contains all the ui of the project, contains sub directory for each screen.
3- utils — Contains the utilities/common functions of your application.
4- widgets — Contains the common widgets for your applications. For example, Button, TextField etc. 
5- controllers — Contains the functions of each screen. 
6- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e orientation etc.
```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:boilerplate/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'ui/splash/splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: SplashScreen(),
    );
  }
}
```

## Conclusion

It was a real fun making this project and  🙂
