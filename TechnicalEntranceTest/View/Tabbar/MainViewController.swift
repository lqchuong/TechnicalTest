//
//  MainViewController.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/29/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit
import DropDown

protocol MainViewDelegate {
    func selectGrid(isGrid: Bool)
}

class MainViewController: UITabBarController {

    var mainTab: MainTabViewController?
    var mainGrid: MainGridViewController?
    var ordersTab: OrdersTabViewController?
    var profileTab: ProfileTabViewController?
    var checkoutTab: CheckoutTabViewController?
    
    var subview:[UIViewController] = []
    var isChangeGrid = false
    var viewDelegate: MainViewDelegate?
    let dropDownProductType = DropDown()
    var productType:[InfoProductType] = []
    var selectedProductTypeIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabbar()
        createRightBarButton()
        getListProductType()
        // Do any additional setup after loading the view.
    }
    
    func loadTabbar()
    {
        
        subview.removeAll(keepingCapacity: false)
        mainTab = MainTabViewController()
        mainGrid = MainGridViewController()
        ordersTab = OrdersTabViewController()
        profileTab = ProfileTabViewController()
        checkoutTab = CheckoutTabViewController()
        subview.append(mainTab!)
        subview.append(ordersTab!)
        subview.append(profileTab!)
        subview.append(checkoutTab!)
        mainTab?.tabBarItem = UITabBarItem(title: "Main", image: #imageLiteral(resourceName: "ic_home"), selectedImage: #imageLiteral(resourceName: "ic_home"))
        mainTab?.tabBarItem.tag = 0
        ordersTab?.tabBarItem = UITabBarItem(title: "Orders", image: #imageLiteral(resourceName: "ic_orders"), selectedImage: #imageLiteral(resourceName: "ic_orders"))
        ordersTab?.tabBarItem.tag = 1
        profileTab?.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "ic_profile"), selectedImage: #imageLiteral(resourceName: "ic_profile"))
        profileTab?.tabBarItem.tag = 2
        checkoutTab?.tabBarItem = UITabBarItem(title: "Checkout", image: #imageLiteral(resourceName: "ic_checkout"), selectedImage: #imageLiteral(resourceName: "ic_checkout"))
        checkoutTab?.tabBarItem.tag = 3
        
        self.setViewControllers(subview, animated: true)
       
        self.selectedIndex = 0
        self.selectedViewController = mainTab
        self.tabBar.tintColor = .red
        self.title = "Product"
        
    }
    func getListProductType(){
        let file = Bundle.main.path(forResource: "ProductType", ofType: "json")
        let u = URL(fileURLWithPath: file!)
        let d = try! Data(contentsOf: u)
        let mang = try! JSONDecoder.init().decode(ProductType.self, from: d)
        self.productType = mang.DS
        
    }
   
    
    @IBAction func showFilterReceiptType() {
        self.dropDownProductType.show()
    }
   
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            tabBar.tintColor = .red
            self.title = "Product"
        case 1:
            tabBar.tintColor = .red
            self.title = "Order"
        case 2:
            tabBar.tintColor = .red
            self.title = "Profile"
        case 3:
            tabBar.tintColor = .red
            self.title = "Checkout"
        default:
            print("no tab")
        }
    }
    func createRightBarButton() {
        let listView    = UIImage(named: "ic_list")!
        let search  = UIImage(named: "ic_search")!
        let listViewButton   = UIBarButtonItem(image: listView,  style: .plain, target: self, action: #selector(self.changeViewProduct))
        let searchButton = UIBarButtonItem(image: search,  style: .plain, target: self, action: #selector(self.searchProduct))
        navigationItem.rightBarButtonItems = [listViewButton, searchButton]
      
    }
    @objc func changeViewProduct(){

                if (isChangeGrid)
                    {
                        subview.remove(at:0)
                        subview.insert(mainTab!, at:0)
                        mainTab?.tabBarItem = UITabBarItem(title: "Main", image: #imageLiteral(resourceName: "ic_home"), selectedImage: #imageLiteral(resourceName: "ic_home"))
                        mainTab?.tabBarItem.tag = 0
                        self.setViewControllers(subview, animated: true)
                        self.selectedIndex = 0
                        self.selectedViewController = mainTab
                        self.tabBar.tintColor = .red
                        isChangeGrid = false
                }else{
                        subview.remove(at:0)
                        subview.insert(mainGrid!, at:0)
                        mainGrid?.tabBarItem = UITabBarItem(title: "Main", image: #imageLiteral(resourceName: "ic_home"), selectedImage: #imageLiteral(resourceName: "ic_home"))
                        mainGrid?.tabBarItem.tag = 0
                        self.setViewControllers(subview, animated: true)
                        self.selectedIndex = 0
                        self.selectedViewController = mainGrid
                        self.tabBar.tintColor = .red
                        isChangeGrid = true
                        }

      }
    
    @objc func searchProduct(){
        let search = SearchProductViewController.init(nibName: "SearchProductViewController", bundle: nil)
        self.navigationController?.pushViewController(search, animated: true)
    }
}
