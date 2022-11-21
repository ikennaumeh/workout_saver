# Magic 
![Coverage](coverage_badge.svg)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)


A flutter test app giving by the Magic team to track and record user workouts.

## Running the App
To run the app, you should fetch all dependencies and run the build_runner   
```
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## App Architecture and Folder Structure

The code of the app implements clean architecture to separate the UI, domain and data layers with a feature-first approach for folder structure, implementing the MVVM architectural pattern.

#### Folder Structure

```
lib
├── core
│   ├── app
│   ├── data
│   ├── models
│   ├── services
│   │   ├── service_api
│   │   └── stream_service
│   └── utils
├── features
│   ├── add_workout
│   │   ├── view_model --- add_workout_vm
│   │   ├── widgets   
│   │   └── view
│   ├── home
│   │   ├── view_model --- home_view_model
│   │   ├── widgets
│   │   └── view
│   └── splash_view
│       ├── view_model --- splash_view_model
│       └── views
|
└── main.dart
```

* `main.dart` has the root `MaterialApp` and all necessary configurations and route settings to start the app
* The `core` folder contains code shared across features
  * `app` contains the code generator for Stacked app, implementations and services.
  * `data` abstract app-level database and workout store to store database
  * `storage` service is implemented with [`Sqflite`](https://pub.dev/packages/sqflite))
  * `models` for create dart classes/models
  * `services` folders for implementing:
      * `service_api` which acts as a layer between the viewmodel and data layer
      * `stream service` contains class for stream service
  * `utils` for colors and size management with [Flutter screen utils](https://pub.dev/packages/flutter_screenutil)


* The `features` folder: contains the core features of the app like:
  * `add workout`
  * `home`
  * `splash screen`


## Testing

The `test` folder mirrors the `lib` folder in addition to some test utilities. And more tests will be added.

[`mocktail`](https://pub.dev/packages/mocktail) is used to mock dependencies. 


### Testing with Stacked

Testing with Stacked is hassle-free and simple. You can test your business logic separately from Flutter, and you can test how they behave in your widgets with widget testing. You can find helpful information about this in the official [docs](https://www.filledstacks.com/post/how-to-unit-test-in-flutter/).

#### 1. Unit Testing

Covered all functions necessary for this app. One would have to get mock and used mocked dependencies of services before carrying out tests.

```dart
    late MockNavigationService mockNavService;
    late MockServiceApi mockServiceApi;
    late MockStreamSubscription mockStreamService;
    late HomeViewModel sut; ///sut means system under tests
    
    setUp(() {
        mockStreamService = MockStreamSubscription();
        sut = HomeViewModel(mockStreamService);
    });

```

and then test like: 

```dart
    test("initials values are correct", () {
       expect(sut.workoutList, []);
    });

```

or group and test with:

```dart
  group("fetchWorkouts", () {
  
    test("fetch workouts using service api", () async {
        serviceApiReturns3Workouts();
        await sut.fetchWorkout();
        verify(() => mockServiceApi.getWorkouts()).called(1);
    
    });
    
    test("sets workoutList to the ones from the service", () async {
        serviceApiReturns3Workouts();
        await sut.fetchWorkout();
        expect(sut.workoutList, workoutsFromService);
    
    });
  
  });

```
## Third party packages

- [Stacked and its services](https://pub.dev/packages/stacked): Used to implement a very clean MVVM architectural pattern,
  state management and navigation service very cleaner.
- [Google fonts](https://pub.dev/packages/google_fonts): Used for implementing custom font.
- [Sqflite](https://pub.dev/packages/sqflite): Used to create and implementing database.
- [Flutter screen utils](https://pub.dev/packages/flutter_screenutil): For adapting to different screen and font sizes to look good on different mobile screens.
- [Mocktail](https://pub.dev/packages/mocktail): Used to create mocks.


## PS: Much thought wasn't given to UI and design. 