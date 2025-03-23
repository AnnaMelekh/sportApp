//
//  HeaderView.swift
//  sportApp
//
//  Created by Anna Melekhina on 23.03.2025.
//

import UIKit

protocol HeaderDelegate {
    func callHeader(idx: Int)
}

final class HeaderView: UIView {
    
    var secIndex: Int?
    var delegate: HeaderDelegate?
    
    lazy var leftImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var rightImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.down")
        img.tintColor = .blue
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = false
        btn.clipsToBounds = false
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 1, height: 2)
        btn.layer.shadowRadius = 4
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 0
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
        btn.addSubview(leftImageView)
        btn.addSubview(rightImageView)
        btn.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 5),
            leftImageView.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 45),
            leftImageView.heightAnchor.constraint(equalToConstant: 45),
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            rightImageView.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -10),
            rightImageView.centerYAnchor.constraint(equalTo: btn.centerYAnchor)
        ])
        
        return btn
    }()
    
    @objc func onClickHeaderView() {
        if let idx = secIndex {
            delegate?.callHeader(idx: idx)
        }
    }
    
    func toggleChevron(isExpandable: Bool) {
        let chevron = isExpandable ? "chevron.up" : "chevron.down"
        UIView.animate(withDuration: 0.3) {
            self.rightImageView.image = UIImage(systemName: chevron)
        }
    }
    
}
