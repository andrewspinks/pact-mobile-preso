# Sample iOS Swift consumer and ruby provider.
This is a demonstation project for using the [Swift Pact library](https://github.com/DiUS/pact-consumer-swift).

### To build and run Pact Swift Tests
The application uses Carthage for building library dependencies. If you are not familiar with carthage, see [Carthage](https://github.com/Carthage/Carthage) for more details.

* Install the pact mock service gem (required for running the iOS Pact tests).
```
gem install pact-mock_service -v 0.3.0
```
*NB:* if you are using the system ruby, you will need to install the gem using sudo. Better options would be to use something like rbenv / rvm / chruby.

* Download and compile the iOS library dependencies:
```
CatKit $ carthage bootstrap
```
(Execute from the CatKit directory)

* Run the iOS unit tests. (can be done from within XCode if you prefer)
```
CatKit $ xcodebuild -project CatKit.xcodeproj -scheme CatKit clean test -sdk iphonesimulator
```
This will run the unit tests (Pact Tests). After the pact tests run successfully the generated pact files should live in the `CatKit/tmp/pacts/` directory. A log of the pact test interactions can be found here `CatKit/tmp/pact.log`. If the tests fail, try looking in here for details as to why.

### Verify the ruby server with the generated pact file
Copy over the generated pact file from the iOS project, to the ruby server.
```
catkit-server $ cp ../CatKit/tmp/pacts/catkit_ios_app-catkit_service.json pacts/ios-app/
```
(Execute from the catkit-server directory)

Run the pact verification to verify that the server conforms to the CatKit client.
```
catkit-server $ bundle exec rake pact:verify
```

# More reading
* [Swift Pact library](https://github.com/DiUS/pact-consumer-swift)
* The original pact library, with lots of background and guidelines [Pact](https://github.com/realestate-com-au/pact)
* The pact mock server that the Swift library uses under the hood [Pact mock service](https://github.com/bethesque/pact-mock_service)
* A pact broker for managing the generated pact files (so you don't have to manually copy them around!) [Pact broker](https://github.com/bethesque/pact_broker)
