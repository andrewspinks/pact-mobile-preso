import Alamofire

public class CatKitClient {
  private let baseUrl: String
  
  public init(baseUrl: String) {
    self.baseUrl = baseUrl
  }
  
  public func feedMe(feedMeResponse: (String, String) -> Void) {
    let headers = [
      "Accept": "application/json"
    ]
    
    Alamofire.request(.GET, "\(baseUrl)/feed-me", headers: headers)
      .responseJSON { (result) in
        if let json = result.result.value as? Dictionary<String, String> {
          feedMeResponse(json["message"]!, json["status"]!)
        }
      }
  }
}
