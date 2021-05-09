//
//  RepoDetailViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 9/5/2021.
//

import UIKit

class RepoDetailViewController: UIViewController {

    // MARK: - Properties
    private let repo: Items
    
    // MARK: - Init
    init(repo: Items) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "This shouldn't be used. use init(repo:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .green
//        let height = self.navigationController?.navigationBar.frame.maxY
//        let dualLabel = LeftRightLabelView(left: "left", right: "right", size: CGSize(width: self.safeAreaFrame.width, height: 20))
//        dualLabel.frame.origin = CGPoint(x: self.safeAreaFrame.origin.x, y: height ?? 0)//self.safeAreaFrame.origin.y + (height ?? 0))
//        self.view.addSubview(dualLabel)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
