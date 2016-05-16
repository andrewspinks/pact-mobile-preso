import Alamofire

public class CatKitClient {
  private let baseUrl: String
  
  public init(baseUrl: String) {
    self.baseUrl = baseUrl
  }
  
  public func feedMe(feedMeResponse: (String, String) -> Void) {
    let headers = [
      "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
      "Accept": "application/json"
    ]
    
    Alamofire.request(.GET, "\(baseUrl)/feedMe", headers: headers)
      .responseJSON { (result) in
        if let json = result.result.value as? Dictionary<String, String> {
          feedMeResponse(json["message"]!, json["status"]!)
        }
      }
  }
}