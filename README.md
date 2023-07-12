# iOS Project - PCBlog-Swift

PCBlog-Swift is an iOS application that displays a collection of blog posts from the PCBlog json feed file. The app provides a user-friendly interface to browse and read blog posts, featuring images and HTML content.

## Features

- Fetches and displays a collection of blog posts from the PCBlog json feed file.
- Allows users to tap on a blog post to view its details.
- Shows a featured image, title, summary, and content of each blog post.
- Supports HTML content rendering using a WebView component.
- Provides a clean and intuitive user interface for easy navigation.

## Requirements

- Xcode 12 or later
- Swift 5.0 or later
- iOS 13.0 or later

## Getting Started

To get started with the PCBlog-Swift project, follow these steps:

1. Clone the repository to your local machine or download the source code as a ZIP file.
2. Open the project in Xcode by double-clicking the `PCBlog-Swift.xcodeproj` file.
3. Build and run the project on the iOS Simulator or a physical device.

## Project Structure

The project follows a standard iOS project structure and consists of the following components:

- `Models`: Contains the data models used in the application, including the `Feed` model and the `Item` model.
- `Services`: Provides networking and image downloading services.
- `Views`: Includes custom views used in the application, such as the `CurrencyCollectionViewCell` and `HeaderView`.
- `ViewControllers`: Contains the main view controller classes, including `CurrencyViewController` and `TransparentWebAlertViewController`.
- `Extensions`: Contains extensions for system classes, such as `UIColor` and `NSAttributedString`.
- `Constants`: Defines constants used throughout the application.

## Usage

Upon launching the app, you will be presented with a collection view displaying a list of blog posts. Each cell in the collection view represents a blog post and displays a featured image, and title.

You can tap on a blog post to view its details. This will open a transparent alert view that shows the blog post's content in an HTML-rendered format. The alert view includes a title, close button, and a web view to display the content.

You can dismiss the alert view by tapping the close button or tapping outside the view.


## Credits

The PCBlog-Swift app is developed by Joseph Rahme
