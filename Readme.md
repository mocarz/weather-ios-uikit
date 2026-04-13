Time spent: 10 h

The application follows the MVVM + Coordinator pattern. The Coordinator handles navigation and dependency management, decoupling view controllers from one another. While this may introduce some overhead for a project of this scope, it provides a solid foundation for future development.

Core dependencies are abstracted behind protocols, allowing underlying implementations to be swapped without modifying dependent components.

I was free to choose the UI framework and UIKit was selected over SwiftUI, with UI layouts defined in Xib files.

An imperative programming model was adopted for simplicity. A reactive approach using Combine or RxSwift would be more appropriate for complex projects.

The UI is intentionally minimal and would require further refinement for a production release.

Code formatting was applied using _swift-format_ with default settings.

Unit tests are incomplete and should be extended to cover all files and edge cases.

The following areas were out of scope and are not currently supported:

- dark mode
- multiple device orientations
- varied device sizes
- app icons
- the launch screen
- strings localization
- UI automated tests
- code coverage reporting
- backward compatibility with older iOS versions
