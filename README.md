# ChargerMap

ChargerMap is an iOS application that showcases electric vehicle (EV) charging sites on a map. Utilizing data fetched from simulated API endpoints, it allows users to explore charging sites and view detailed information about the chargers and their statuses.

## Features

- Fetch and parse JSON data for charging sites and chargers.
- Visualize charging sites with annotations on a map.
- View detailed information about chargers at a selected site.
- Color-coded charger statuses for easy identification.

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+

## Installation

1. Clone the repository:
   
2. Open `ChargerMap.xcodeproj` in Xcode.

3. Install third-party frameworks using Swift Package Manager (SPM):
   - Navigate to `File` > `Add Packages...`
   - Search for the required package URLs and add them to your project.
     - RealmSwift

4. Select a target device or simulator running iOS 16.0 or later.

5. Build and run the project.

## Usage

Upon launching the app, users are presented with a map displaying annotations for each charging site. Tapping an annotation reveals a callout with basic site information and an option to view more details, including the available chargers and their statuses.

## Architecture and Design Patterns

ChargerMap employs the MVVM (Model-View-ViewModel) architecture, complemented by the Coordinator pattern for navigation management, ensuring a clean separation of concerns and enhancing maintainability.

- **MVVM**: This pattern facilitates a clear separation between the application's logic (ViewModel), its presentation layer (View), and the data model (Model). ViewModels communicate changes to the Views using data binding (facilitated by SwiftUI and Combine), minimizing the View's logic.

- **Coordinator**: The Coordinator pattern manages the navigation flow within the app, decoupling view controllers from their navigation logic. This approach simplifies transitions and contexts switching, making the app's navigation more flexible and easier to understand.

- **Repository Pattern**: For data handling, ChargerMap utilizes the Repository pattern to abstract the data layer. This pattern provides a clean API for data access to the rest of the application, allowing for simpler data fetching and persistence management, and making the switch between local and remote data sources seamless.

## Use Cases

- **Exploring Charging Sites**: Users can visually explore the map, which displays annotations for each charging site. This feature uses MapKit for mapping and annotation functionalities.

- **Viewing Charger Details**: Tapping on a site's annotation opens a detail view showing the chargers available at that site, their specifications, and statuses. This part leverages SwiftUI for modern and responsive UI components.

- **Offline Data Access**: With RealmSwift, ChargerMap caches data locally, allowing users to access previously loaded charging site and charger details without an internet connection.


## Contributing

Contributions are welcome! Please submit pull requests or open issues to discuss proposed changes or enhancements.


