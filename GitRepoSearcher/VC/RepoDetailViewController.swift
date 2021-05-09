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
    
    @available(*, unavailable, message: "This should be used. use init(repo:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
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
