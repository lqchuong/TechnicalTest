//
//  SearchProductViewController.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit
import ExpyTableView

class SearchProductViewController: UIViewController {

    @IBOutlet weak var sb_Search: UISearchBar!
    @IBOutlet weak var bt_Exit: UIButton!
    @IBOutlet weak var tb_Product: ExpyTableView!
    
    
    var product:[Info] = []
    var groupProduct:[GroupProductType] = []
    var count = 0
    var strSearch = ""
    var timerSearch = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        getListProduct()
        initTable()
        // Do any additional setup after loading the view.
    }
    @IBAction func bt_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func initTable(){
       
        self.tb_Product.register(SearchProductTableViewCell.self, forCellReuseIdentifier: "SearchVideoTableViewCell")
        self.tb_Product.register(UINib(nibName: "SearchVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchVideoTableViewCell")
        self.tb_Product.register(SearchProductTableViewCell.self, forCellReuseIdentifier: "SearchProductTableViewCell")
        self.tb_Product.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchProductTableViewCell")
        self.tb_Product.register(HeaderViewCell.self, forCellReuseIdentifier: "HeaderViewCell")
        self.tb_Product.register(UINib(nibName: "HeaderViewCell", bundle: nil), forCellReuseIdentifier: "HeaderViewCell")
        self.tb_Product.dataSource = self
        self.tb_Product.delegate = self
        self.sb_Search.delegate = self
       
        self.getListProduct()
   
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func getListProduct(){
        groupProduct.removeAll(keepingCapacity: true)
        product.removeAll(keepingCapacity: true)
        let file = Bundle.main.path(forResource: "Product", ofType: "json")
        let u = URL(fileURLWithPath: file!)
        let d = try! Data(contentsOf: u)
        let mang = try! JSONDecoder.init().decode(Product.self, from: d)
        self.product = mang.DS
        for item in product {
            if let group = self.getExistGroup(type: item) {
                group.Detail.append(item)
            } else {
                let newGroup = GroupProductType()
                newGroup.title = item.TypeDisplay
                newGroup.Detail.append(item)
                groupProduct.append(newGroup)
            }
        }
        for i in 0...groupProduct.count{
            tb_Product.expand(i)
        }
       
    }
    func getListGroupProduct(product: Info){
        
    }
    func getExistGroup(type: Info) -> GroupProductType? {
        for group in groupProduct {
            if (group.title == type.TypeDisplay) {
                return group
            }
        }
        return nil
    }
}

extension SearchProductViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            getListProduct()
            tb_Product.reloadData()
            return
        }
        timerSearch.invalidate()
        count = 0
        timerSearch = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
       
    }
    @objc func countTime(){
        count += 1
        if (count == 2){
           
            filterContentForSearchText(searchText: sb_Search.text!)
        }
    }
    func filterContentForSearchText(searchText: String) {
        groupProduct.removeAll(keepingCapacity: true)
        if searchText == "" {
            getListProduct()
            tb_Product.reloadData()
            return
        }
        self.product = self.product.filter({( aSpecies: Info) -> Bool in
            let name = ConverHelper.convertVietNam(text: aSpecies.Name.lowercased())
            let searchText = ConverHelper.convertVietNam(text: searchText.lowercased())
            return name.range(of: searchText) != nil
        })
        for item in product {
            if let group = self.getExistGroup(type: item) {
                group.Detail.append(item)
            } else {
                let newGroup = GroupProductType()
                newGroup.title = item.TypeDisplay
                newGroup.Detail.append(item)
                groupProduct.append(newGroup)
            }
        }
        for i in 0...groupProduct.count{
            tb_Product.expand(i)
        }
        tb_Product.reloadData()
        print(product)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        let textField: UITextField = searchBar.value(forKey: "_searchField") as! UITextField
        textField.clearButtonMode = .never
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    
}
extension SearchProductViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupProduct.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupProduct.count == 0 {
            return 0
        }
        let product = groupProduct[section]
        return product.Detail.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if (product[indexPath.section].TypeDisplay == 0){
            return 80
        }
        if (product[indexPath.section].TypeDisplay == 1){
           return 80
        }
       return 0
        
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let products = groupProduct[indexPath.section]
        let product = products.Detail[indexPath.row-1]
        if (product.TypeDisplay == 0){
        let cellIdentifier = "SearchProductTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! SearchProductTableViewCell
       
        cell.loadData(product: product)
        return cell
        } else{
            let cellIdentifier = "SearchVideoTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! SearchVideoTableViewCell
            
            cell.loadData(product: product)
            return cell
        }
    }
}
extension SearchProductViewController: ExpyTableViewDataSource {
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cellIdentifier = "HeaderViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! HeaderViewCell
        let group = groupProduct[section]
        cell.loadData(title: "\(group.title)")
       
        return cell
    }
   
}

extension SearchProductViewController: ExpyTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
        if indexPath.row == 0 {
            return
        }
        let groups = groupProduct[indexPath.section]
        let data = groups.Detail[indexPath.row-1]
        let detailProduct = DetailViewController.init(nibName: "DetailViewController", bundle: nil)
        detailProduct.product = data
        self.navigationController?.pushViewController(detailProduct, animated: true)
      
    }
}
