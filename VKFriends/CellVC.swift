
import UIKit

class CellVC: UITableViewCell {
    
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var dataInfo: Friend? {
        didSet {
            setupCellData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        faceImageView.layer.cornerRadius = 25
        faceImageView.clipsToBounds = true
    }
    
    func setupCellData() {
        if let dataInfo = dataInfo {
            firstnameLabel.text = dataInfo.firstname
            lastnameLabel.text = dataInfo.lastname
            cityLabel.text = dataInfo.city
            faceImageView.image = UIImage.init(data: photoFromVK(image: dataInfo.image))
        }
    }
    
    func photoFromVK(image: String) -> Data {
        var data = Data()
        let url = URL.init(string: image)
        
        do {
            data = try Data(contentsOf: url!)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return data
    }
}
