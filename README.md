# Rule Engine Application

## Overview

This Flutter application implements a 3-tier rule engine system with a simple UI, API, and backend. It uses Abstract Syntax Trees (AST) to represent conditional rules, allowing for dynamic creation, combination, and modification of these rules.

## Features

- Create and parse complex rules using a custom rule language
- Combine multiple rules into a single AST
- Evaluate rules against user-provided data
- Visualize the AST structure
- Persist rules using SQLite database
- User authentication using Firebase

## Design Choices

1. **Rule Representation**: We use an Abstract Syntax Tree (AST) to represent rules. This allows for flexible and complex rule structures that can be easily traversed and evaluated.

2. **Rule Parser**: A custom parser is implemented to convert string representations of rules into AST structures. This allows users to input rules in a more natural language-like format.

3. **Rule Evaluation**: The AST is traversed recursively to evaluate rules against provided data. This approach allows for efficient evaluation of complex nested rules.

4. **Data Storage**: SQLite is used for local storage of rules. This provides a lightweight, serverless database solution suitable for mobile applications.

5. **State Management**: Provider is used for state management, allowing for efficient updates to the UI when rules or data change.

6. **Authentication**: Firebase Authentication is integrated to provide secure user authentication.

## Dependencies

- Flutter SDK: >=2.19.0 <3.0.0
- provider: ^6.0.0
- sqflite: ^2.0.0+3
- path_provider: ^2.0.2
- firebase_core: ^2.4.1
- firebase_auth: ^4.2.5

## Build Instructions

1. Ensure you have Flutter installed on your system. If not, follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).

2. Clone this repository:
   ```
   git clone https://github.com/your-username/rule-engine-app.git
   cd rule-engine-app
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Set up Firebase:
   - Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/)
   - Add an Android app to your Firebase project and download the `google-services.json` file
   - Place the `google-services.json` file in the `android/app` directory of your Flutter project
   - Add an iOS app to your Firebase project and download the `GoogleService-Info.plist` file
   - Place the `GoogleService-Info.plist` file in the `ios/Runner` directory of your Flutter project

5. Run the app:
   ```
   flutter run
   ```

## Usage

1. Launch the app and register or log in using the authentication screen.
2. On the home screen, enter a rule in the provided text field. For example:
   ```
   (age > 30 AND department = 'Sales') OR (experience > 5 AND salary < 50000)
   ```
3. Tap "Add Rule" to parse and store the rule.
4. Enter test data in JSON format in the "Enter Data" field. For example:
   ```json
   {"age": 35, "department": "Sales", "experience": 7, "salary": 60000}
   ```
5. Tap "Evaluate Rule" to see the result.
6. Use the "View AST" button to visualize the structure of the parsed rule.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.