//
//  IGFeedPostGeneralTableViewCell.swift
//  CoolInstagram
//
//  Created by Vincent Moyo on 2022/02/03.
//

import UIKit

/// Comments
class IGFeedPostGeneralTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostGeneralTableViewCell"
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "   Go Citizens!"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(commentLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commentLabel.frame = contentView.bounds
    }
}
