import Foundation
import SwiftyJSON

class NetworkManager {
    
    var friendsArray = [Friend]()
    
    private let baseURL = "https://api.vk.com/method/"
    let offcet = 10
    
    func loadJSONFriends(successful: @escaping ([Friend], Error?) -> Void) {
    
        let method = "friends.get?user_id=10&count=\(offcet)&fields=nickname%2C%20domain%2C%20bdate%2C%20city%2C%20country%2C%20timezone%2Cphoto_200_orig%2C%20has_mobile%2C%20contacts%2C%20education%2C%20status%2C%20can_see_all_posts&v=5.63"
        let finalURL = baseURL + method
        
        let url = URL(string: finalURL)!
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            do {
                
                let json = try JSON(data: data)
                if let json = json["response"]["items"].array {
                    for item in json {
                        let id = item["id"].intValue
                        let name = item["first_name"].stringValue
                        let surname = item["last_name"].stringValue
                        let city = item["city"]["title"].stringValue
                        let image = item["photo_200_orig"].stringValue
                        
                        let friends = Friend(id: id, firstname: name, lastname: surname, city: city, image: image)
                        
                        self.friendsArray.append(friends)
                    }
                }
            }
                
            catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                successful(self.friendsArray, error)
            }
        }
        session.resume()
    }
}
