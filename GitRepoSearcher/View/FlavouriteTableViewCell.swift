//
//  FlavouriteTableViewCell.swift
//  GitRepoSearcher
//
//  Created by carlhung on 10/5/2021.
//

import UIKit

class FlavouriteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    class var cellHeight: CGFloat {
        return 44
    }
    
    class var identifier: String {
        "FlavouriteTableViewCell"
    }
    
    class var leftRightLabelSpace: CGFloat {
        20
    }
    
    class var buttonWidth: CGFloat {
        44
    }
    
    var label = UILabel()
    var flavouritedButton = UIButton()
    let heartImage = UIImage(named: "heart")
    var isFlavourite:Bool!

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    @available(*, unavailable, message: "This shouldn't be used. use init(style:reuseIdentifier:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Setup
    func setup() {
        setupLabel()
        setupButton()
    }
    
    func setupLabel() {
        self.label.frame.size.height = self.frame.size.height
        self.label.frame.origin.x = Self.leftRightLabelSpace
        self.contentView.addSubview(self.label)
    }
    
    func setupButton() {
        self.flavouritedButton.frame.size = CGSize(width: Self.buttonWidth, height: Self.cellHeight)
        self.flavouritedButton.addTarget(self, action: #selector(self.flavouritedButtonPressed), for: .touchUpInside)
        
//        button.setImage(UIImage.init(named: "uncheck"), for: UIControl.State.normal)//When selected
//        button.setImage(UIImage.init(named: "check"), for: UIControl.State.highlighted)//When highlighted
//        button.setImage(UIImage.init(named: "check"), for: UIControl.State.selected)//When selected
        self.contentView.addSubview(self.flavouritedButton)
    }
    
    // MARK: - Renew
    func renewCell(text: String, flavourited: Bool, availableWidth: CGFloat) {
        self.label.text = text
        self.label.frame.size.width = availableWidth - Self.buttonWidth - (Self.leftRightLabelSpace * 2)
        self.flavouritedButton.frame.origin.x = self.label.frame.maxX
        self.flavouritedButton.setImage(flavourited ? heartImage : heartImage?.withTintColor(.gray), for: .normal)
        self.isFlavourite = flavourited
    }
    
    // MARK: - Button Event
    @objc
    func flavouritedButtonPressed() {
        self.isFlavourite = !self.isFlavourite
        self.flavouritedButton.setImage(self.isFlavourite ? heartImage : heartImage?.withTintColor(.gray), for: .normal)
    }
}
