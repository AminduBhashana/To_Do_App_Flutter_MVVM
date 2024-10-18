# Task Manager App
This is a Flutter-based mobile application that allows users to manage their tasks efficiently. Users can add, view, update, and delete tasks, with each task having a due date and time. Tasks are sorted in ascending order based on their due date and time. The application is built following the MVVM (Model-View-ViewModel) architecture pattern and utilizes SQLite for local data storage.

## Features

- **Add New Tasks** : Users can add new tasks with a title, description, due date, and time.
- **Edit Tasks** : Existing tasks can be edited to update details like task name, description, due date, and time.
- **Delete Tasks** : Users can delete tasks from the list.
- **Task List** : Displays a list of tasks in ascending order based on the due date and time.
- **Splash Screen** : A splash screen is shown when the app is launched.
- **Data Persistence** : Task data is stored locally using SQLite.
- **User-Friendly UI** : A clean and responsive UI is provided for managing tasks.


## Technologies Used

- **Flutter** : Cross-platform mobile development framework.
- **Dart** : Programming language used for Flutter development.
- **SQLite (sqflite package)** : Local database to store task data.
- **Provider** : State management package for handling state between views and view models.

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/AminduBhashana/To_Do_App_Flutter_MVVM.git
    ```

2. **Install dependencies**:

    ```bash
    cd To_Do_App_Flutter_MVVM
    flutter pub get
    ```

3. **Run the app**:

    ```bash
    flutter run
    ```

## Features in Detail

### Splash Screen
When the app is launched, a splash screen appears, displaying a welcoming interface before navigating to the task management screen.

### Task Management
- **Add a Task** : Users can click the "Add Task" button to create a new task. A form is provided to input the task name, description, due date, and time.
- **Edit a Task** : Tap on an existing task to edit it. The current task details will be pre-filled in the form.
- **Delete a Task** : Swipe a task or click a delete button to remove it from the list.
- **Task Sorting** : Tasks are automatically sorted by due date and time in ascending order.

### Local Storage with SQLite
The application uses the **sqflite** package to persist data locally. A repository pattern is implemented to handle database interactions.

## Screenshots


## License
This project is licensed under the MIT License.          

