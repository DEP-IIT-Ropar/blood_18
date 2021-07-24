# Blood donor/seeker app

A new Flutter project.

## Getting Started

Blood Donor App:
This is an app that connects blood donors with the seekers.
This app uses flutter and firebase and the push notifications are executed by cloud functions in firebase.

Steps for installation and running:

	Client app:
	1. We are using android studio for this, you can download it from web.
	2. Download this zip file and extract it.
	3. Open android studio -> click file -> new -> import project -> select the project file (Blood donor main) in the extracted folder.
	4. Go to file -> project structure -> then in project sdk, select any virtual device or select "1.8 java version <version>".
	5. To get the dependencies, run
		 $ flutter pub get 
	5. If you picked "1.8 java version", then connect an andriod phone to the pc with usb.
	   Switch on the usb debugging in the phone, you may find it in the developer options in the device's settings.
	6. It will initiate, then wait for the play button to appear, then select the required device, then press the play.
	7. It may prompt you to install various plugins, but the prompt will be staright forward and you will be redirected to install the 
	   required plugins.
	8. It will compile and run on the connected device.

	Firestore Database:

	1. Setup a new firebase project, for that, refer https://firebase.google.com/docs/flutter/setup
	2. Then open firestore and create following collections => userInfo, medInfo, request, request_donor

	Then open the cloud functions in the firebase and do the following,

	Cloud Functions for push notifications:

	Install node in your pc.
	Open project folder and install firebase tool package using
	1. $ npm install -g firebase-tools this command
	2. Then login using 
		$ firebase login
	Select your existing project from firebase using $ firebase init functions

	Write the functions that are present in index.js. 
	We have used HTTP triggers for calling the cloud functions.
	There are two parameters ‘token’ and ‘seekerName’ and these parameters are used to send notifications
	to specific donors containing this token and seeker name to display in the notification.

	After writing the cloud functions save the file and deploy using the below command
	$ firebase deploy --only functions


For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
