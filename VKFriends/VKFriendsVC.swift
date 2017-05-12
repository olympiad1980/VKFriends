
import UIKit

class VKFriendsVC: UIViewController {
    
    static let cellIdentifier = "cellIdentifier"
    let friends = NetworkManager()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.separatorStyle = .none
        addUser()
    }
    
    @IBAction func addUserContactAction(_ sender: UIButton) {
        addUser()
    }
    
    func addUser() {
        friends.loadJSONFriends { (successful, error) in
            if let error = error {
                print("error, \(error)")
            }
                
            else {
                self.myTableView.reloadData()
            }
        }
    }
}

extension VKFriendsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendsCount = friends.friendsArray
        
        return friendsCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VKFriendsVC.cellIdentifier, for: indexPath) as! CellVC
        
        let friendsIndexPathForRow = friends.friendsArray[indexPath.row]
        cell.dataInfo = friendsIndexPathForRow
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightForRowAt: CGFloat = 100
        return heightForRowAt
    }
}
