//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jonathan Du on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usertagLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var user = User.current!
        usernameLabel.text = user.name
        usertagLabel.text = user.screenName
        tweetsLabel.text = String(User.current?.dictionary!["statuses_count"] as! Int)
        followersLabel.text = String(User.current?.dictionary!["followers_count"] as! Int)
        followingLabel.text = String(User.current?.dictionary!["friends_count"] as! Int)
        profileImageView.af_setImage(withURL: user.profileURL)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
