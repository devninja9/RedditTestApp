//
//  HomeViewController.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var posts: [PostEntity] = []
    var loadingPostData = false
    var sinkToken:AnyCancellable?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        fetchPostData()
    }
    
    func setupViews() {
        navigationItem.title = "Home"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cell: [PostCell.className])
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPostData), for: .valueChanged)
    }
    
    func fetchPostData() {
        loadingPostData = true
        presentSpinner()
        
        sinkToken = RedditAPI.fetchPost()
            .print()
            .sink(receiveCompletion: { completion in
                self.dismissSpinner()
                
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.showAlert(title: Strings.error, message: Strings.failed_fetch_data)
                }
            }, receiveValue: {
                self.posts = $0.data.children.map { children in children.data }
                self.tableView.reloadData()
            })
    }
    
    @objc func refreshPostData(_ sender: Any) {
        self.refreshControl.endRefreshing()
        
        fetchPostData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostCell = tableView.dequeueReusableCell(index: indexPath)
        cell.selectionStyle = .none
        cell.imageView?.image = UIImage()
        cell.setPost(data: posts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PostCell.heightForCell(data: posts[indexPath.row], width: Int(self.view.bounds.width))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == posts.count - 1) && !loadingPostData {
            fetchPostData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigatePostDetailScreen(posts[indexPath.row])
    }
    
    private func navigatePostDetailScreen(_ data: PostEntity) {
        let viewController = PostDetailViewController(nibName: PostDetailViewController.className, bundle: nil)
        viewController.post = data
        navigationController?.pushViewController(viewController, animated: true)
    }
}
