//
//  FlavouriteTableViewCell.swift
//  GitRepoSearcher
//
//  Created by carlhung on 10/5/2021.
//

import UIKit
import CoreData

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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var label = UILabel()
    var flavouredButton = UIButton()
    let heartImage = UIImage(named: "heart")
    var isFlavoured: Bool!
    var item: Items!
    
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
        self.flavouredButton.frame.size = CGSize(width: Self.buttonWidth, height: Self.cellHeight)
        self.flavouredButton.addTarget(self, action: #selector(self.flavouredButtonPressed), for: .touchUpInside)
        self.contentView.addSubview(self.flavouredButton)
    }
    
    // MARK: - Common
    func fetch(id: String) throws -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Flavorite")
        request.predicate = NSPredicate(format: "id = %@", id)
        request.returnsObjectsAsFaults = false
        let result = try context.fetch(request) as? [NSManagedObject]
        return result
    }
    
    // MARK: - Renew
    func renewCell(item: Items, availableWidth: CGFloat) {
        self.item = item
        self.label.text = self.item.name
        self.label.frame.size.width = availableWidth - Self.buttonWidth - (Self.leftRightLabelSpace * 2)
        self.flavouredButton.frame.origin.x = self.label.frame.maxX
        self.isFlavoured = false
        self.flavouredButton.setImage(heartImage?.withTintColor(.gray), for: .normal)
        guard let id = self.item.id else { return }
        do {
            if let result = try self.fetch(id: String(id)), result.count == 1 {
                self.flavouredButton.setImage(heartImage, for: .normal)
                self.isFlavoured = true
            }
        } catch {
            print("FlavouriteTableViewCell renewCell - ERROR: \(error)")
        }
    }
    
    // MARK: - Button Event
    @objc
    func flavouredButtonPressed() {
        print("FlavouriteTableViewCell flavouredButtonPressed")
        self.isFlavoured = !self.isFlavoured
        self.flavouredButton.setImage(self.isFlavoured ? heartImage : heartImage?.withTintColor(.gray), for: .normal)
        guard let idInt = self.item.id else { return }
        let id = String(idInt)
        do {
            guard let result = try fetch(id: id) else { return }
            if !self.isFlavoured {
                guard result.count == 1 else { return } // It should return 1 result if it was found. Because `id` is unqiue.
                context.delete(result[0])
                try context.save()
            } else {
                guard result.count == 0 else { return }
                let entity = NSEntityDescription.entity(forEntityName: "Flavorite", in: context)
                let flavorite = NSManagedObject(entity: entity!, insertInto: context)
                flavorite.setValue(id, forKey: "id") // `id` is unqiue(constraint). Duplicated `id` won't be happened. Once the `id` was saved. it means it is flavoured.
                try context.save()
            }
        } catch {
            print("FlavouriteTableViewCell flavouredButtonPressed - ERROR: \(error)")
        }
    }
}
