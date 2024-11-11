# 📋 Flutter Client Management Test

## 📘 Description

This application was developed as a technical test for client management in Flutter. The app provides the following features:

- 🆕 Create, delete, and modify clients (CRUD functionality).
- 📋 Display a client list with a search bar, loading results in batches of 5.
- 🔑 Login screen to connect with an API, obtaining an access token required for authenticating requests to the Client API.

### 🕰️ Development Time

This test took approximately **35** hours to complete.

## ⚙️ Project Setup

To compile and run the application, follow these steps:

1. **Clone the repository**:

   ```bash
   git clone git@github.com:Diana-Paez/tost_test.git

2. **Install dependencies:**

   ```bash
    flutter pub get

3. **Set the JDK path in android/gradle.properties:** Ensure gradle.properties contains the following line with the path to your JDK 17 installation:

    ```bash
    org.gradle.java.home=/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home

4. **Run the application:**

   ```bash
    flutter run

## 🛠️ **Architecture and Packages Used**

- **stacked**: For state management and implementing MVVM architecture.
- **http**: To perform HTTP requests and token-based authentication.
- **flutter_secure_storage**: For secure storage of the authentication token.

## 📱 **Screen Descriptions**

- **Login**: The initial screen allows users to enter their credentials, connect to the authentication API, and obtain an access token.
- **Client List**: A screen that shows a list of clients with a search bar. Results load in batches of 5 clients at a time.
- **Client CRUD**: Functionality for adding, deleting, and modifying client details.
