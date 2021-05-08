//
//  ExtenUIViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 8/5/2021.
//

import Foundation
import UIKit

/*
 if (@available(iOS 11.0, *)) {
     UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
     safeAreaFrame = CGRectMake(safeAreaInsets.left,
                                safeAreaInsets.top,
                                self.view.frame.size.width - safeAreaInsets.left - safeAreaInsets.right,
                                self.view.frame.size.height - safeAreaInsets.top - safeAreaInsets.bottom);
 } else {

     safeAreaFrame = self.view.frame;
 }
 */

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
//    var safeAreaFrame: CGRect {
////        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.window
//        if #available(iOS 11.0, *),
//           let safeAreaInsets = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.window?.safeAreaInsets {
////            if let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets {
////                let topMargin =  window.safeAreaInsets.top
////                let leftMargin =  window.safeAreaInsets.left
//                return CGRect(x: safeAreaInsets.left,
//                              y: safeAreaInsets.top,
//                              width: self.view.frame.size.width - safeAreaInsets.left - safeAreaInsets.right,
//                              height: self.view.frame.size.height - safeAreaInsets.top - safeAreaInsets.bottom)
////            }
////            let safeAreaInsets = self.view.safeAreaInsets
////            return CGRect(x: safeAreaInsets.left,
////                          y: safeAreaInsets.top,
////                          width: self.view.frame.size.width - safeAreaInsets.left - safeAreaInsets.right,
////                          height: self.view.frame.size.height - safeAreaInsets.top - safeAreaInsets.bottom)
//        } else {
//            return self.view.frame
//        }
//    }
    
//    var safeAreaFrame: CGRect {
//        if #available(iOS 11.0, *), let safeAreaInsets = self.view.window?.safeAreaInsets {
//            return CGRect(x: safeAreaInsets.left,
//                          y: safeAreaInsets.top,
//                          width: self.view.frame.size.width - safeAreaInsets.left - safeAreaInsets.right,
//                          height: self.view.frame.size.height - safeAreaInsets.top - safeAreaInsets.bottom)
//        } else {
//            return self.view.frame
//        }
//    }
}
