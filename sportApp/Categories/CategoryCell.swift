//
//  Untitled.swift
//  sportApp
//
//  Created by Anna Melekhina on 23.03.2025.
//

import UIKit

final class CategoryCell: UITableViewCell {
    
    private lazy var subcategories: [String] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            return CategoryCell.createLayoutForCollection()
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SubcategoryCell.self, forCellWithReuseIdentifier: "SubcategoryCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false 
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with subcategories: [String]) {
        self.subcategories = subcategories
        collectionView.reloadData()
    }
    
    static func createLayoutForCollection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        return section
    }
    
    private func categorySelected(subcategory: String) {
//        guard let parentVC = self.parentViewController as? MainViewController else { return }
//
//        let title = parentVC.data.first(where: { $0.subType.contains(subcategory) })?.headerName ?? "Unknown"
//
//            switch title {
//            case "Men":
//                productsCategorised = products.filter { $0.category == "men's clothing" }
//            case "Women":
//                productsCategorised = products.filter { $0.category == "women's clothing" }
//            case "Electronics":
//                productsCategorised = products.filter { $0.category == "electronics" }
//            case "Jewelry":
//                productsCategorised = products.filter { $0.category == "jewelery" }
//            default:
//                print("No matching category")
//            }

//            let vc = ShopViewController()
//            vc.products = productsCategorised
//            vc.hidesBottomBarWhenPushed = true
//            parentVC.navigationController?.pushViewController(vc, animated: true)
//            parentVC.navigationController?.isNavigationBarHidden = false
//            parentVC.navigationItem.backButtonTitle = ""
        }
    }


extension CategoryCell: UICollectionViewDelegate {}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubcategoryCell", for: indexPath) as! SubcategoryCell
        cell.configure(title: subcategories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.contentView.backgroundColor = UIColor.systemRed

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            cell.contentView.backgroundColor = UIColor.white
        }
        self.categorySelected(subcategory: self.subcategories[indexPath.row])
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
