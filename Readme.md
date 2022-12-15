# MemoMap

MemoMap is a digital map diary app for connecting with friends through sharing photo memories tagged onto an interactive map. Add memories by capturing a front and back photo using the in-app camera and immediately see it show up as a pin on the map. MemoMap makes it easy to look back on all the memories you've made and the places you've been as pins on a map, and it's a great way to stay connected with friends who are traveling or living far away.


## Setup

Clone the repository into your target directory:

```shell
git clone https://github.com/kimberlygao/memo-map.git
```

Navigate into the target directory from the terminal and run:

```shell
pod install
```

If you don't have a podfile already you may need to this first:

```shell
pod init
```
Then edit your podfile using a text editor:
```shell
# Uncomment the next line to define a global platform for your project
  platform :ios, '15'

target 'memoMap' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for memoMap
  pod "Cluster"
end
```

Open up the project in Xcode (must be Version 14.1 and higher)

Start running the app!


## For the best experience...

- When the app first launches you need to tap “Allow Camera” and “Allow Location” then relaunch the app in order to get the full experience with the user locating feature.

- Ensure that the device you are running memoMap on is in light mode

## Testing notes
We set up our unit testing files, which build, run, and pass. However, testing our app requires making calls to our Firestore database. After working with multiple TAs for over three hours and combing through every stackoverflow article, we still were not able to resolve the fatal thread error that we had. We tried millions of variations of linking and unlinking targets and binaries and also adding ```FirebaseApp.configure()``` in various possible places, but nothing was successful.

Instead, we manually tested all of our functions using print statements, displaying it in the content view, and double-checking that the data was properly added/updated/deleted on Firestore. We felt that this way of testing still allowed us to ensure that our app was working as expected and also gave us more time to focus on refining details in our app. 
