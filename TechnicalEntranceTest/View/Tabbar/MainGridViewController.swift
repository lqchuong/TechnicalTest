//
//  MainGridViewController.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class MainGridViewController: UIViewController {

    @IBOutlet weak var cl_Product: UICollectionView!
    
    let cellSpacing:CGFloat = 10
    var product:[Info] = []
    var listType:[ListTypeDetail] = []
    private let sectionInsets = UIEdgeInsets(top: 5.0,
                                             left: 5.0,
                                             bottom: 5.0,
                                             right: 5.0)
    private let itemsPerRow: CGFloat = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        getListProduct()
        initCollection()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func getListProduct(){
        let file = Bundle.main.path(forResource: "Product", ofType: "json")
        let u = URL(fileURLWithPath: file!)
        let d = try! Data(contentsOf: u)
        let mang = try! JSONDecoder.init().decode(Product.self, from: d)
        self.product = mang.DS
        
    }
    func initCollection(){ self.cl_Product.register(GridProductCollectionViewCell.self, forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        self.cl_Product.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        self.cl_Product.delegate = self
        self.cl_Product.dataSource = self
    }

}
extension MainGridViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "GridProductCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GridProductCollectionViewCell
        cell.loadData(product: product[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailProduct = DetailViewController.init(nibName: "DetailViewController", bundle: nil)
        detailProduct.product = product[indexPath.row]
        self.navigationController?.pushViewController(detailProduct, animated: true)
    }
}
extension MainGridViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 2)
        let availableWidth = Constant.screenWidth - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 110)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
