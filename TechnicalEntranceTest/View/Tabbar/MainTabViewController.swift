//
//  MainTabViewController.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/29/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit


class MainTabViewController: UIViewController {

    @IBOutlet weak var tb_Product: UITableView!
   
    var product:[Info] = []
    var listType:[ListTypeDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initTable()
        getListProduct()
       
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    
    }
    
    func initTable() {
        self.tb_Product.register(ListProductTableViewCell.self, forCellReuseIdentifier: "ListProductTableViewCell")
        self.tb_Product.register(UINib(nibName: "ListProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ListProductTableViewCell")
        self.tb_Product.dataSource = self
        self.tb_Product.delegate = self
    }
    
    func getListProduct(){
        let file = Bundle.main.path(forResource: "Product", ofType: "json")
        let u = URL(fileURLWithPath: file!)
        let d = try! Data(contentsOf: u)
        let mang = try! JSONDecoder.init().decode(Product.self, from: d)
        self.product = mang.DS
        
    }
}
extension MainTabViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListProductTableViewCell",for: indexPath) as! ListProductTableViewCell
        cell.loadData(product: product[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailProduct = DetailViewController.init(nibName: "DetailViewController", bundle: nil)
        detailProduct.product = product[indexPath.row]
        self.navigationController?.pushViewController(detailProduct, animated: true)
        
    }
    
}

