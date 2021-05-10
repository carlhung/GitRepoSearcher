//
//  RepoDetailViewController.swift
//  GitRepoSearcher
//
//  Created by carlhung on 9/5/2021.
//

import UIKit
import WebKit

class RepoDetailViewController: UIViewController {

    // MARK: - Properties
    private let repo: Items
    private var webViewY: CGFloat!
    private let webView = WKWebView()
    
    
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
        self.setup()
    }
    
    // MARK: - Setup
    func setup() {
        self.setupSelf()
        self.setupNavigationBar()
        self.setupLabels()
        self.setupWebView()
    }
    
    func setupSelf() {
        self.view.backgroundColor = .white
    }
    
    func setupNavigationBar() {
        self.title = self.repo.name
    }
    
    func setupLabels() {
        let height = self.navigationController?.navigationBar.frame.maxY ?? 0
        let additionalSpace: CGFloat = 2
        let startY = height + additionalSpace
        let dualLabelSize = CGSize(width: self.safeAreaFrame.width, height: 20)
        let firstDualLabel = LeftRightLabelView(left: "forks: \(repo.forks.stringValue)", right: "issues: \(repo.open_issues.stringValue)", size: dualLabelSize)
        let secondDualLabel = LeftRightLabelView(left: "watchers: \(repo.watchers.stringValue)", right: "size: \(repo.size.stringValue)", size: dualLabelSize)
        let thirdualLabel = LeftRightLabelView(left: "description: \(repo.description ?? "N/A")", right: "default branch: \(repo.default_branch ?? "N/A")", size: dualLabelSize)

        webViewY = [firstDualLabel, secondDualLabel, thirdualLabel].reduce(startY) { result, label in
            label.frame.origin = CGPoint(x: self.safeAreaFrame.origin.x, y: result)
            self.view.addSubview(label)
            return  result + label.frame.height + additionalSpace
        }
    }
    
    func setupWebView() {
        guard let repoUrl = repo.html_url, let branch = repo.default_branch else { return }
        let urlStr = repoUrl + "/blob/" + branch + "/README.md"
        guard let url = URL(string: urlStr) else { return }
        self.webView.frame = CGRect(x: self.safeAreaFrame.origin.x, y: self.webViewY, width: self.safeAreaFrame.width, height: self.view.frame.height - self.webViewY)
        self.view.addSubview(self.webView)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
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

fileprivate extension Optional where Wrapped == Int {
    var stringValue: String {
        if let val = self {
            return String(val)
        } else {
            return "N/A"
        }
    }
}
