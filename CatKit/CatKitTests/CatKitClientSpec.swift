import Quick
import Nimble
import PactConsumerSwift
import CatKit

class CatKitClientSpec: QuickSpec {
  override func spec() {
    var catKitService: MockService?
    var catKitClient: CatKitClient?

    describe("tests fulfilling all expected interactions") {
      beforeEach {
        catKitService = MockService(provider: "CatKit Service", consumer: "CatKit iOS App")
        catKitClient = CatKitClient(baseUrl: catKitService!.baseUrl)
      }

      it("it feeds my cat") {
        catKitService!.uponReceiving("a request for feeding")
                     .withRequest(
                      method: .GET,
                        path: "/feed-me",
                        headers: ["Accept": "application/json"])
                     .willRespondWith(
                        status: 200,
                        headers: ["Content-Type": "application/json"],
                        body: [ "message": "Meow!", "status": "happy"])

        //Run the tests
        catKitService!.run { (testComplete) -> Void in
          // Test the client
          catKitClient!.feedMe { (message, status) -> Void in
            expect(status).to(equal("happy"))
            expect(message).to(equal("Meow!"))
            testComplete()
          }
        }
      }
    }
  }
}
