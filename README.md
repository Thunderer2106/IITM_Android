# iitm_android

A new Flutter project.

## Getting Started

Command to enter after extracting code :
flutter pub get
flutter run


Credentials:
user@gmail.com
123456


ACTIVITY 1:
The first activity of the app is a login screen designed with a clean and user-friendly layout. It features
two input fields for email and password, making it easy for users to provide their credentials. Below
the input fields, there is a prominent "Login" button that users can tap to initiate the authentication
process. It checks the user's input against hardcoded credentials fed in Firebase. To enhance security,
both fields are required to be filled; otherwise, the screen displays clear error messages prompting
users to enter their username and password, the format of email is also checked. Additionally, if the
user enters incorrect credentials, the app provides an error message to inform them of the issue.
ACTIVITY 2:
On successful authentication the user is navigated to the dashboard which has two features in which
one amongst them is Storing messages , which has a interface that has three text input fields for
getting Number , Email and Description as input . The inputs are validated before getting stored in
the firebase. Additionally, the image picker lets user upload a image and the data of upload is fetched
automatically in the backend. On clicking submit the form containing input field is validated and is
stored in the dedicated collection called ‘messages’ in Firestore. On successful storage in the backend
the user is prompted with a ‘Submitted’ message.
The app has the feature to view all the stored messages in the Firestore that the user has sent. The
messages are listed in a Listview panel with scrollable feature. The messages are ordered linearly and
on tapping a message a dialog panel opens to give elaborate information about the chosen
message. During the time interval when the UI is interacting with the backend for fetching and
retrieving data , a loading indicator appears implying the ongoing communication.
