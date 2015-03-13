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
        catKitService = MockService(provider: "CatKit Service", consumer: "CatKit iOS App", done: { result in
          expect(result).to(equal(PactVerificationResult.Passed))
        })
        catKitClient = CatKitClient(baseUrl: catKitService!.baseUrl)
      }

      it("it feeds my cat") {
        var complete: Bool = false

        catKitService!.uponReceiving("a request for feeding")
                     .withRequest(
                        .Get,
                        path: "/feedMe",
                        headers: ["Accept": "application/json"])
                     .willRespondWith(
                        200,
                        headers: ["Content-Type": "application/json"],
                        body: [ "message": "Meow!", "status": "happy"])

        //Run the tests
        catKitService!.run { (testComplete) -> Void in

          // Test the client
          catKitClient!.feedMe { (message, status) -> Void in
            expect(status).to(equal("happy"))
            expect(message).to(equal("Meow!"))
            
            complete = true
            testComplete()
          }

          return
        }

        // Test assertion, waiting for asynch requests to finish
        expect(complete).toEventually(beTrue())
      }
    }
  }
}
