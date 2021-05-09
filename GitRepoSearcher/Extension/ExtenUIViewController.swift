//
//  ExtenUIViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 8/5/2021.
//

import Foundation
import UIKit

extension UIViewController {
    var safeAreaFrame: CGRect {
        if #available(iOS 13.0, *), UIApplication.shared.windows.count > 0 {
            let safeAreaInsets = UIApplication.shared.windows[0].safeAreaInsets
            return CGRect(x: safeAreaInsets.left,
                          y: safeAreaInsets.top,
                          width: self.view.frame.size.width - safeAreaInsets.left - safeAreaInsets.right,
                          height: self.view.frame.size.height - safeAreaInsets.top - safeAreaInsets.bottom)
        } else {
            return self.view.frame
        }
    }
}
