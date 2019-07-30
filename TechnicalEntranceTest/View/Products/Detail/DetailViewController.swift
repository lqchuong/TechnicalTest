//
//  DetailViewController.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var img_Product: UIImageView!
    @IBOutlet weak var lb_Name: UILabel!
    
    @IBOutlet weak var tb_Extras: UITableView!
    @IBOutlet weak var lb_Description: UILabel!
    @IBOutlet weak var lb_Weight: UILabel!
    @IBOutlet weak var lb_Cost: UILabel!
    @IBOutlet weak var lb_Ingredients: UILabel!
    var product:Info?
    var extras :[ExtrasDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        createRightBarButton()
        loadData()
        initTable()
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    func createRightBarButton() {
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(self.Order))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    @objc func Order(){
        
    }
    func initTable() {
        self.tb_Extras.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: "ProductDetailTableViewCell")
        self.tb_Extras.register(UINib(nibName: "ProductDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailTableViewCell")
        self.tb_Extras.dataSource = self
        self.tb_Extras.delegate = self
    }
    func loadData()
    {
        
        img_Product.image = UIImage.init(named: product!.Url)
        lb_Name.text = product?.Name
        lb_Description.text = product?.Description
        lb_Weight.text = "\(product!.Weight)g"
        lb_Cost.text = "$\(product!.Cost)"
        lb_Ingredients.text = product?.Ingredient
        extras = product!.Extras
    }

}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell",for: indexPath) as! ProductDetailTableViewCell
        cell.loadData(extras: extras[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "EXTRAS"
    }
    
}
extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
