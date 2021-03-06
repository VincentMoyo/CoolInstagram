//
//  ProfileInfoHeaderCollectionReusableView.swift
//  CoolInstagram
//
//  Created by Vincent Moyo on 2022/02/04.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test2")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.text = "150"
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "1 160"
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.text = "2 547"
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit your profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Vince Moyo"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Man city Caption \nSoccer Player \nStriker \nNumber 10 t-shirt"
        label.textColor = .label
        label.numberOfLines = 4
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width / 4
        
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2.0
        
        let buttonHeight = profilePhotoSize / 2
        let countButtonWidth = (width - 10 - profilePhotoSize) / 3
        
        postLabel.frame = CGRect(x: profilePhotoImageView.right,
                                  y: 5,
                                  width: countButtonWidth,
                                  height: buttonHeight).integral
        
        postButton.frame = CGRect(x: profilePhotoImageView.right,
                                  y: 30,
                                  width: countButtonWidth,
                                  height: buttonHeight).integral
        
        followersLabel.frame = CGRect(x: postButton.right,
                                       y: 5,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postButton.right,
                                       y: 30,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        followingLabel.frame = CGRect(x: followersButton.right,
                                      y: 5,
                                      width: countButtonWidth,
                                      height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.right,
                                       y: 30,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                         y: 20 + buttonHeight,
                                         width: countButtonWidth * 3,
                                         height: buttonHeight).integral
        
        nameLabel.frame = CGRect(x: 5,
                                 y: 5 + profilePhotoImageView.bottom,
                                 width: width - 10,
                                 height: 50).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        
        bioLabel.frame = CGRect(x: 5,
                                y: 5 + nameLabel.bottom,
                                width: width - 10,
                                height: bioLabelSize.height).integral
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followersLabel)
        addSubview(followingLabel)
        addSubview(followingButton)
        addSubview(postButton)
        addSubview(postLabel)
        addSubview(editProfileButton)
        addSubview(bioLabel)
        addSubview(nameLabel)
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self,
                                  action: #selector(didTapFollowerButton),
                                  for: .touchUpInside)
        
        followingButton.addTarget(self,
                                  action: #selector(didTapFollowingButton),
                                  for: .touchUpInside)
        
        postButton.addTarget(self,
                                  action: #selector(didTapPostsButton),
                                  for: .touchUpInside)
        
        editProfileButton.addTarget(self,
                                  action: #selector(didTapEditProfileButton),
                                  for: .touchUpInside)
    }
    
    // MARK: - Actions

    @objc private func didTapFollowerButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
