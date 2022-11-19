## Architectural choice

I decided to go with the MVVM architecture which is one of my favourites as it helps largely
with separate of concerns. Separating business logic from UI. MVVM with Stacked allows me to have 
view, and view models that feed data to the view, and services, which when implemented correctly
creates nice abstraction layer for relating with external and third party services.

## Third party packages

- Stacked and its services: Used to implement a very clean MVVM architectural pattern,
state management and navigation service very cleaner.
- Google fonts: Used for implementing custom font.
- Sqflite: Used to create and implementing database.
- Flutter screen utils: For adapting to different screen and font sizes to look good on different mobile screens.
- Mocktail: Used to create mocks.
