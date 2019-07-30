//
//  NavigationController.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/29/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
