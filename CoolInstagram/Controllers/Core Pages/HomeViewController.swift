//
//  ViewController.swift
//  CoolInstagram
//
//  Created by Vincent Moyo on 2022/02/01.
//

import FirebaseAuth
import UIKit

struct HomeFeedRenderViewModel {
    let header: PostRenderPhotoViewModel
    let post: PostRenderPhotoViewModel
    let actions: PostRenderPhotoViewModel
    let comments: PostRenderPhotoViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    private var counter = 0
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    private func createMockModels() {
        let user = User(username: "@vince_nkosi",
                        bio: "Man city",
                        name:(first: "", last: ""),
                        profilePhoto: URL(string: "https://www.google.com")!,
                        birthDate: Date(),
                        gender: .male,
                        counts: UserCount(followers: 10, following: 12, posts: 1),
                        joinedDate: Date())
        
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [""],
                            owner: user)
        
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "@John",
                                        text: "Wow!",
                                        createdDate: Date(),
                                        likes: []))
        }
        for _ in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderPhotoViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderPhotoViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderPhotoViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderPhotoViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
        } else if subSection == 1 {
            // post
            return 1
        } else if subSection == 2 {
            // actions
            return 1
        } else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(_): return 1
            case.header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            switch model.header.renderType {
            case .header(provider: let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as? IGFeedPostHeaderTableViewCell
                cell?.configure(with: provider)
                cell?.delegate = self
                return cell ?? UITableViewCell()
            case.comments, .actions, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 1 {
            // post
            let postModel = model.post
            switch postModel.renderType {
                
            case.header, .actions, .comments: return UITableViewCell()
            case .primaryContent(provider: let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as? IGFeedPostTableViewCell
                counter += 1
                cell?.configure(with: provider, number: counter)
                return cell ?? UITableViewCell()
            }
        } else if subSection == 2 {
            // actions
            let actionModel = model.actions
            switch actionModel.renderType {
                
            case.header, .primaryContent, .comments: return UITableViewCell()
            case .actions(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as? IGFeedPostActionsTableViewCell
                cell?.delegate = self
                return cell ?? UITableViewCell()
            }
        } else if subSection == 3 {
            // comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case.header, .actions, .primaryContent: return UITableViewCell()
            case .comments(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as? IGFeedPostGeneralTableViewCell
                
                return cell ?? UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            return 70
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return 60
        } else if subSection == 3 {
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate, IGFeedPostActionsTableViewCellDelegate {
    
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func reportPost() {
        print("Report")
    }
    
    func didTapLikeButton() {
        print("Like")
    }
    
    func didTapCommentButton() {
        print("Comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
}
