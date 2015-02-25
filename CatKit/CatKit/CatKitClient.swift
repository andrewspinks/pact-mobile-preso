import Alamofire

public class CatKitClient {
  private let baseUrl: String
  
  public init(baseUrl : String) {
    self.baseUrl = baseUrl
  }
  
  public func feedMe(feedMeResponse: (String) -> Void) {
    Alamofire.request(.GET, "\(baseUrl)/feedMe")
      .responseJSON {
        (_, _, json, _) in
        if let json = json as? Dictionary<String, AnyObject> {
          feedMeResponse(json["response"] as String)
        }
      }
  }
}