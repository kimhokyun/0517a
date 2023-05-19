//
//  ViewController.swift
//  0517a
//
//  Created by hokyun Kim on 2023/05/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var filterPickerView: UIPickerView!
    @IBOutlet weak var sortingPickerView: UIPickerView!
    
    var responseData : Data = Data(shopList: [])
    var filteredData : Data = Data(shopList: [])
    var sortedData : Data = Data(shopList: [])
    var filterCode : String = "ALL"
    var sortingType : String = "기본 정렬순"
    var shopList : [Shop] = []
    
    let filterList = ["전체","치킨","피자","분식","카페"]
    let filterCodeList = ["ALL","CK","PZ","SF","CF"]
    let sortingList = ["기본 정렬순","별점 높은순","리뷰 많은순"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
        
        sortingPickerView.delegate = self
        sortingPickerView.dataSource = self

        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3300/dcx/1/shopList") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let Data = try decoder.decode(Data.self, from: data)
                self.responseData = Data
                self.filteredData = Data
                self.sortedData = Data
                self.shopList = Data.shopList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(self.shopList)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    

    func applyPickerData(){
        if filterCode == "ALL" {
            self.filteredData = self.responseData
        }else {
            self.filteredData.shopList = self.responseData.shopList.filter { $0.category == filterCode }
        }
        
        
        switch sortingType {
        case "별점 높은순":
            self.sortedData.shopList = self.filteredData.shopList.sorted { $0.point > $1.point }
        case "리뷰 많은순":
            self.sortedData.shopList = self.filteredData.shopList.sorted { $0.review > $1.review }
        default :
            self.sortedData = self.filteredData
        }
        
        self.tableView.reloadData()
        

    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedData.shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let shop = self.sortedData.shopList[indexPath.row]
        cell.imageFileImageView.image = UIImage(named: shop.imageFile)
        cell.nameLabel.text = shop.name
        cell.pointLabel.text = "별점 : \(shop.point)"
        cell.reviewLabel.text = "리뷰 : \(shop.review)"
        cell.adFlagImageView.isHidden = shop.adFlag == "Y" ? false : true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.sortedData.shopList[indexPath.row].id
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true)
        
    }

}


extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == filterPickerView {
            return filterList.count
        }else if pickerView == sortingPickerView {
            return sortingList.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == filterPickerView {
            return filterList[row]
        }else if pickerView == sortingPickerView {
            return sortingList[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == filterPickerView {
            filterCode = self.filterCodeList[row]
        }else if pickerView == sortingPickerView {
            sortingType = self.sortingList[row]
        }
        
        applyPickerData()
    }

}
