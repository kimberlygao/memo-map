# memoMap

memoMap is an app for people to keep in touch with friends by sharing travel and food photos. We are a digital map diary of places you've visited, which is not only fun to look back on but also share with friends. Users are able to create "memories" at a place by capturing a BeReal-style photo. All "memories" can be viewed either as a "pin" on the map or in a grid format. With searchable locations and a daily prompt feature that allows for fresh content, memoMap is the next-generation social media platform.


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


## For the best experience,

- When the app first launches you need to tap “Allow Camera” and “Allow Location” then relaunch the app in order to get the full experience with the user locating feature.

- Ensure that the device you are running memoMap on is in light mode
