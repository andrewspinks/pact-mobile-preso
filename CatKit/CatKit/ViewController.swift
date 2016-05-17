
import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var catImageView: UIImageView!
  @IBOutlet weak var feedMeButton: UIButton!
  @IBOutlet weak var responseText: UILabel!
  var catKitClient = CatKitClient(baseUrl: "http:localhost:9292")

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func feedMe(source: UIButton) -> Void {
    self.catKitClient.feedMe { (response, status) -> Void in
      self.catImageView.image = UIImage(named: "satisfied")
      self.responseText.text = response
      self.responseText.hidden = false
      self.feedMeButton.hidden = true
    }
  }
}
