//
//  GridProductViewController.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/29/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class GridProductViewController: UIViewController {

    @IBOutlet weak var cl_Product: UICollectionView!
    
    var product:[Info] = []
    let cellSpacing:CGFloat = 10
    private let sectionInsets = UIEdgeInsets(top: 5.0,
                                             left: 5.0,
                                             bottom: 5.0,
                                             right: 5.0)
    private let itemsPerRow: CGFloat = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        getListProduct()
        initCollection()
       
    }
    func initCollection(){
        let flowLayout = UICollectionViewFlowLayout()

//
//              let a = Int(self.view.frame.width) - 20

//        flowLayout.itemSize = CGSize(width:a/2 , height: 300)
//
//        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
//        //
//        self.cl_Product?.collectionViewLayout = flowLayout
//        //
        self.cl_Product.register(GridProductCollectionViewCell.self, forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        self.cl_Product.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        self.cl_Product.delegate = self
        self.cl_Product.dataSource = self
    }
    func getListProduct(){
        let file = Bundle.main.path(forResource: "Product", ofType: "json")
        let u = URL(fileURLWithPath: file!)
        let d = try! Data(contentsOf: u)
        let mang = try! JSONDecoder.init().decode(Product.self, from: d)
        self.product = mang.DS
    }

}
extension GridProductViewController:UICollectionViewDataSource, UICollectionViewDelegate {
   
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
        let detailProduct = ProductDetailViewController.init(nibName: "ProductDetailViewController", bundle: nil)
        detailProduct.product = product[indexPath.row]
        self.navigationController?.pushViewController(detailProduct, animated: true)
    }
}
extension GridProductViewController : UICollectionViewDelegateFlowLayout {
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
