//
//  LeftRightLabelView.swift
//  GitRepoSearcher
//
//  Created by carlhung on 9/5/2021.
//

import UIKit

class LeftRightLabelView: UIView {
    
    // MARK: - Properties
    var leftLabel = UILabel()
    var rightLabel = UILabel()
    var hStack: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually//.fillProportionally
        hStack.alignment = .center
        return hStack
    }()
    
    // MARK: - Init
    init(left: String, right: String, size: CGSize) {
        super.init(frame: .zero)
        self.setup(left: left, right: right, size: size)
    }
    
    @available(*, unavailable, message: "This shouldn't be used. use init(left:right:availableWidth:height:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setup(left: String, right: String, size: CGSize) {
        self.setupSelf(size: size)
        self.setupHStack()
        [(self.leftLabel, left), (self.rightLabel, right)].forEach {
            self.setupLabel(label: $0, text: $1)
        }
    }
    
    func setupSelf(size: CGSize) {
        self.frame.size = size
    }
    
    func setupLabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .center
        label.layer.cornerRadius = self.frame.size.height / 2
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        self.hStack.addArrangedSubview(label)
    }
    
    func setupHStack() {
        self.hStack.frame.size = self.frame.size
        self.addSubview(hStack)
    }
}
