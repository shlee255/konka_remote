# konka_remote

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Create flutter project
1. Launch VS Code
Open VS Code or your preferred Code OSS editor.

2. Open the command palette
Go to View > Command Palette or press Control + Shift + P.

3. Find the Flutter commands
In the command palette, start typing flutter:. VS Code should surface commands from the Flutter plugin.

4. Run the new project command
Select the Flutter: New Project command. Your OS or VS Code might ask for access to your documents, agree to continue to the next step.

5. Choose a template
VS Code should prompt you with Which Flutter template?. Depending on what type of Flutter project you want to create, choose the corresponding template. For a new Flutter app, choose Application.

6. Select a project location
A file dialog should appear. Select or create the parent directory where you want the project to be created. Don't create the project folder itself, the Flutter tool does so. To confirm your selection, click Select a folder to create the project in.

7. Enter a project name
VS Code should prompt you to enter a name for your new project. Enter a name for your app that follows the lowercase_with_underscores naming convention, following the Effective Dart guidelines. To confirm your selection, press Enter.

8. Wait for project initialization
Based on the information you entered, VS Code uses flutter create to bootstrap your app. Progress is often surfaced as a notification in the bottom right and can also be accessed from the Output panel.

9. Run your app
Your new app should now be created and open in VS Code. To try your new app, follow the steps to run and debug in VS Code.

10. Added permission in the Manifests (\android\app\src\main\AndroidManifest.xml)
 <uses-permission android:name="android.permission.TRANSMIT_IR" />

11. Add ir_sensor_plugin
flutter pub add ir_sensor_plugin

https://github.com/yeikel16/ir_sensor_plugin

https://github.com/e200/flutter-remote

