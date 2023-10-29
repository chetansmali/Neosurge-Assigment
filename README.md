# neosurge_finance

A new Flutter project.

## Getting Started
## link  https://drive.google.com/drive/folders/1AXaRGfC1iYMV0hA4stwQpOclk-r_I7O9?usp=sharing

step 1 : Login / Singnup

step 2 : Dashboard

step 3 : Add Income / Add Expense 

step 4 : Analytics 

step 5 : Profile

Clean Architecture -
The app is structured using Clean Architecture, which includes layers like Presentation, data, Domain, and Infrastructure.Clean Architecture enforces a clear separation of concerns. In a finance tracking app, it's essential to keep the core financial and business logic independent of the UI or external dependencies. Clean Architecture ensures that the financial calculations and rules are contained in the Domain layer, promoting testability and maintainability.

BLoC for State Management:
BLoC (Business Logic Component) is used for state management in the app.BLoC allows you to manage and isolate the app's state and business logic separately from the UI, making it easier to test and maintain. This is particularly beneficial for a finance tracking app, where the state needs to be updated and displayed in response to user actions and data changes.

Separation of UI and Business Logic:
The Presentation layer is responsible for UI, while the Domain layer contains the core business logic.Separating the UI from business logic is crucial for maintainability. It makes it easier to make changes to the UI without affecting the core financial calculations or data handling.

Testability:
With Clean Architecture and BLoC, the app is structured to be highly testable, with business logic and UI components decoupled.Testability is essential for ensuring the reliability of a personal finance app. By structuring the code to be easily testable, you can write unit tests for the core financial calculations and ensure the accuracy of the app's calculations, which is vital for financial data.


