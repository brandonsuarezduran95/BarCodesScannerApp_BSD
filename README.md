#  BarCodeScannerApp_BSD

This App is a demonstration of the usage of the following Swift Package:

BarCodeScanner_BSD_SDK
https://github.com/brandonsuarezduran95/BarCodeScanner_BSD_SDK

This project has the following features:

-> The Entry Point uses a programmatic approach to show the MainViewController
-> Programmatic UI

### Architecture
This app uses the MVC Architecture since it is a single target app and no network calls are required.
A NavigationController is set as the app's entry controller, this enables a smooth navigation between the root controller and the ScannerController.

### Usage

The app is simple and concise. After the App Launches, select the "+" button to specify what type of 'BarCode Symbology' to scan.
Press the 'Start Scanning' button to transition to the scanner view. If a Successful read out is performed, haptic feedback will be played.
The text below the scanner view will show the data read from the bar codes, and will be updated as new nada is read.



