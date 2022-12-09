# memoMap

##### Usage

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
