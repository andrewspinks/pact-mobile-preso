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
        var feedingResponse: String = ""

        catKitService!.uponReceiving("a request for feeding")
                      .withRequest(PactHTTPMethod.Get, path: "/feedMe")
                      .willRespondWith(200,
                        headers: ["Content-Type": "application/json"],
                        body: [ "response" : "Meow!"])

        //Run the tests
        catKitService!.run { (testComplete) -> Void in

          // Test the client
          catKitClient!.feedMe { response in
            feedingResponse = response
            testComplete()
          }

          return
        }

        // Test assertion, waiting for asynch requests to finish
        expect(feedingResponse).toEventually(equal("Meow!"))
      }
    }
  }
}
