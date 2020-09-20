import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var friends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        let friend: Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        cell.imageView?.image = nil
        
        DispatchQueue.global().async {
                   guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return  }
             guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
        
 
        DispatchQueue.main.async {
            if let index: IndexPath = tableView.indexPath(for: cell) {
            if index.row == indexPath.row {
                cell.imageView?.image = UIImage(data: imageData)
                }
            }
        }
    }
           
       
        return cell
    }
}

extension ViewController{
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else { return }
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.friends = apiResponse.results
                
                DispatchQueue.main.async {
                     self.tableView.reloadData()
                }
               
            } catch(let err){
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
}

