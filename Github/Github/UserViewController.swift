//
//  ViewController.swift
//  Github
//
//  Created by DxO Labs on 02/05/2018.
//  Copyright © 2018 DxO Labs. All rights reserved.
//

import UIKit
import SafariServices

class UserViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    private let github = Github()
    private let user = User.apple
    private var userDetail: UserDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetail = try? github.getData(ofType: UserDetails.self, at: user.url)
        nameLabel.text = userDetail?.name
        urlLabel.text = userDetail?.short_url
        locationLabel.text = userDetail?.location
        if let userDetail = userDetail {
            avatarImageView.image = try! github.getImage(from: userDetail)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func blogButtonTApped(_ sender: Any) {
        guard let blog = userDetail?.blog else {return}
        let safari = SFSafariViewController(url: blog)
        present(safari, animated: true, completion: nil)
    }
    
}

