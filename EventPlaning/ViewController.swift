//
//  ViewController.swift
//  EventPlaning
//
//  Created by SRIKIRAN INAGANTI on 5/19/21.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var eventSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var array = [Event]()
    var eventModel:EventModel?
    var filteredData:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerTableviewCell()
        downloadWithJSOn()
        eventSearchBar.delegate = self
        
    }
    
    func registerTableviewCell() {
        let nib =  UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    
    func downloadWithJSOn() {
        let url = "https://api.seatgeek.com/2/events?client_id=MjE5NjQ3ODJ8MTYyMTQ3NzkxNy45NjYzNTc1"
        
        let urlObjc = URL(string: url)!
        URLSession.shared.dataTask(with:urlObjc){(data,response,error) in
            do {
                self.eventModel = try! JSONDecoder().decode(EventModel.self, from:data!)
                self.array = self.eventModel!.events
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch
            {
                print(error)
            }
            
        }.resume()
        
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else{
            return UITableViewCell()
        }
        let event:Event = array[indexPath.row]
        
        cell.locationLabel.text = event.venue.displayLocation
        cell.titleLabel.text = event.venue.nameV2
        cell.dateLabel.text = event.datetimeUTC
        //        let defaultlink = "https://api.seatgeek.com/2/events?client_id=MjE5NjQ3ODJ8MTYyMTQ3NzkxNy45NjYzNTc1/"
        let completelink =  event.performers[0].image
        cell.eventImageView.downloaded(from: completelink)
        cell.eventImageView.contentMode = .scaleAspectFill
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier:"DetailViewController" ) as? DetailViewController
        self.navigationController?.pushViewController((vc)!, animated: true)
        let event:Event = array[indexPath.row]
        vc?.name = event.venue.nameV2
        vc?.location = event.venue.displayLocation
        vc?.date = event.datetimeUTC
        let completelink =  event.performers[0].image
        let data = NSData(contentsOf: NSURL(string:completelink)! as URL)
        vc?.newImage = UIImage(data: data! as Data)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
}



extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {   UIView.ContentMode.self
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
