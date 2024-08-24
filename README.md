# Github Developers App

Github Developers App is a SwiftUI-based application that allows users to search for and view detailed information about GitHub developers. This app is designed with a clean, user-friendly interface and follows the MVVM (Model-View-ViewModel) architecture for better code organization and maintainability.

## Features

- **Search GitHub Users:** Enter a GitHub username to fetch and display detailed information.
- **Developer Details:** View developer details, including avatar, name, bio, location, company, repositories, followers, and more.
- **Responsive UI:** The app features a responsive design that adapts to different screen sizes.
- **Asynchronous Data Loading:** Data is fetched asynchronously to ensure a smooth user experience.

## Screenshots

![Home Screen](screenshots/home_screen.png)
![Developer Details](screenshots/developer_details.png)

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/github-developers-app.git
    ```
2. Open the project in Xcode:
    ```bash
    cd github-developers-app
    open GithubDevelopers.xcodeproj
    ```
3. Build and run the app on your simulator or device.

## Usage

- On the home screen, enter a GitHub username.
- Tap on the search button to fetch the developer's details.
- View detailed information, including the developer's avatar, bio, location, repositories, and more.

## Architecture

This app is built using the MVVM (Model-View-ViewModel) architecture, which separates the business logic from the UI components. The `DeveloperDetailViewModel` handles data fetching and formatting, while `DeveloperDetailView` manages the UI presentation.

## Technologies Used

- **SwiftUI:** For building the user interface.
- **Combine:** For reactive data binding.
- **URLSession:** For making network requests to the GitHub API.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or features you'd like to add.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
