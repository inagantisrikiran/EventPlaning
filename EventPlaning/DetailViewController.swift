//
//  DetailViewController.swift
//  EventPlaning
//
//  Created by SRIKIRAN INAGANTI on 5/19/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var detailImageView: UIImageView!
    var name = ""
    var location = ""
    var date = ""
    var newImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        namelabel.text = name
        locationLabel.text = location
        dateLabel.text = date
        detailImageView.image = newImage
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
