# Xpresion Mobile App

Minimum specs to run Flutter:
    Requirement	                    Minimum	            Recommended
    x86_64 CPU Cores	            4	                8
    Memory in GB	                8               	16
    Display resolution in pixels	WXGA (1366 x 768)	FHD (1920 x 1080)
    Free disk space in GB	        4.0	                52.0

Steps to run the app:
- Run the command flutter doctor to make sure that flutter is correctly installed and stable
- Use command prompt to navigate to the project folder
- Connect a mobile device to the pc with usb debugging turned on for the mobile device
- Run the command `flutter run`

Steps to build an apk/appbundle:
- Follow steps 1-3 on https://firebase.google.com/docs/flutter/setup?platform=ios
- Follow the steps mentioned in https://docs.google.com/document/d/1XUiBTGhVdFJoE1mM0h1CiWndcBooOML6G9xOnNZrbl0/edit?usp=sharing
- Run the command `flutter build apk / flutter build appbundle`