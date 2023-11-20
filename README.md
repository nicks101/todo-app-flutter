# TODO

Flutter and Firebase app for managing your To-Do list.

## Features:
- User authentication with email and password
- Add to-do items
- Mark items as done
- Profile page with user info
- Logout

## Technologies used:
- Flutter for the mobile app
- Firebase as the serverless backend, with Firestore for the database and Firebase Authentication for user authentication.
- Riverpod for state management and dependency injection

## Cloud Firestore structure:
- users
  - user_id
    - name
    - email
    - todos
      - todo_id
        - title
        - isDone
        
## Future Scope that can be added:
- Sharing lists with other users
- Collaborating on lists with other users along with providing access control
- Adding due dates to items
- Adding reminders
- Search functionality
- Adding tags to items


