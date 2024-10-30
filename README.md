# Timetable Generation Application

A Flutter-based timetable generation application that allows administrators to manage courses, subjects, staff, and generate weekly timetables. The application provides automatic timetable generation, ensuring that staff assignments align with their availability and subject expertise.

## Features

### 1. Course Management
- **CRUD Operations**: Administrators can create, read, update, and delete courses.
- **Subject Association**: Each course can have multiple associated subjects.

### 2. Subject Management
- **Subject Creation**: Add subjects under specific courses to organize the curriculum.

### 4. Staff Management
- **CRUD Operations**: Manage staff by adding, editing, or deleting staff members.
- **Subject Proficiency**: Assign multiple subjects to each staff member based on their expertise.

### 5. Staff Assignment
- **Assign Staff to Subjects**: Enable the assignment of staff members to specific subjects.

### 6. Timetable Generation
- **Automatic Timetable Generation**: Generate timetables for each course in a day(column)/period(row) format.
  - Ensures there are no conflicts with staff availability.
  - Subjects are evenly distributed across the week.
- **Manual Adjustment**: Allow administrators to manually adjust the generated timetable if needed.

## Technical Specifications

- **Frontend**: Developed using Flutter for a seamless cross-platform experience.
- **Backend**: Developed using firebase for realtime data management.

## Getting Started

To get started with this application:

1. **Flutter Setup**: Ensure Flutter is installed and properly set up. [Install Flutter](https://docs.flutter.dev/get-started/install).
2. **Clone the Repository**: Clone this repository to your local machine.
3. **Install Dependencies**: Run `flutter pub get` to install dependencies.
4. **Configure Backend**: Choose either Firebase or SQLite for data storage and configure accordingly.
5. **Run the Application**: Use `flutter run` to launch the app on a connected device or emulator.
