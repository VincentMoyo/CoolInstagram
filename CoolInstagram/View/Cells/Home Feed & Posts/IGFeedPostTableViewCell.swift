//
//  IGFeedPostTableViewCell.swift
//  CoolInstagram
//
//  Created by Vincent Moyo on 2022/02/03.
//

import AVFoundation
import SDWebImage
import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost, number num: Int) {
        print("wrjhwrghwshnw \(num)")
        postImageView.image = UIImage(named: "test\(num)")
        return
//        switch post.postType {
//        case .video:
//            player = AVPlayer(url: post.postURL)
//            playerLayer.player = player
//            playerLayer.player?.volume = 0
//            playerLayer.player?.play()
//        case .photo:
//            postImageView.sd_setImage(with: post.postURL, completed: nil)
//        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        postImageView.frame = contentView.bounds
        playerLayer.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.image = nil
    }
}
