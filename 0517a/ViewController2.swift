//
//  ViewController2.swift
//  0517a
//
//  Created by hokyun Kim on 2023/05/19.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageFileImageView: UIImageView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var id : Int?
    var responseData : DataDetail = DataDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(id: self.id ?? 0)
        
        // Do any additional setup after loading the view.
    }
    
    func fetchData(id:Int) {
        guard let url = URL(string: "http://localhost:3300/dcx/1/shopDetail/\(id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let Data = try decoder.decode(DataDetail.self, from: data)
                self.responseData = Data
                DispatchQueue.main.async {
                    print(self.responseData)
                    self.fetchUI()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchUI() {
        guard let shop = responseData.shop else { return }
        self.nameLabel.text = shop.name
        self.imageFileImageView.image = UIImage(named: shop.imageFile ?? "")
        self.pointLabel.text = "\(shop.point ?? 0)"
        self.reviewLabel.text = "\(shop.review ?? 0)"
        self.distanceLabel.text = shop.distance
        self.timeLabel.text = shop.time
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
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


