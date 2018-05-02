//
//  RepoViewController.swift
//  Github
//
//  Created by DxO Labs on 02/05/2018.
//  Copyright © 2018 DxO Labs. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let user = User.apple
    private let github = Github()
    
    private let reposDataSource = ReposDataSource()
    
    override func viewDidLoad() {
        let userDetails = try? github.getData(ofType: UserDetails.self, at: user.url)
        let repos = try? github.getData(ofType: [RepoDetails].self, at: userDetails!.repos_url)
        reposDataSource.repos = repos!
        tableView.dataSource = reposDataSource
    }
    
    class ReposDataSource: NSObject, UITableViewDataSource {
        var repos = [RepoDetails]()
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return repos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for : indexPath) as! RepoCell
            cell.configure(with: repos[indexPath.row])
            return cell
        }
    }
}

class RepoCell : UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
    
    func configure(with repo: RepoDetails) {
        titleLabel.text = repo.full_name
        secondLabel.text = repo.language
        thirdLabel.text = repo.desc
        fourthLabel.text = ""
        fifthLabel.text = "\(repo.watchers)"
        sixthLabel.text = ""
    }
}
