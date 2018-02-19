//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jonathan Du on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
class DetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetLabel.text = tweet.text
        usernameLabel.text = tweet.user.name
        retweetLabel.text = "\(String(tweet.retweetCount))"
        favoriteLabel.text = "\(String(describing: tweet.favoriteCount!))"
        dateLabel.text = tweet.createdAtString
        handleLabel.text = "@\(tweet.user.screenName)"
        profileImage.af_setImage(withURL: URL(string: tweet.imageURL)!)
        profileImage.layer.cornerRadius = 16
        profileImage.clipsToBounds = true
        
        if let favoriteCount = tweet.favoriteCount {
            favoriteLabel.text = "\(favoriteCount)"
        }
        if let favorited = tweet.favorited, favorited {
            favoriteImage.image = UIImage(named: "favor-icon-red")
        } else {
            favoriteImage.image = UIImage(named: "favor-icon")
        }
        
        if tweet.retweeted {
            retweetImage.image = UIImage(named: "retweet-icon-green")
        } else {
            retweetImage.image = UIImage(named: "retweet-icon")
        }
        retweetImage.isUserInteractionEnabled = true
        favoriteImage.isUserInteractionEnabled = true
        retweetImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(retweetPost)))
        favoriteImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoritePost)))
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func favoritePost() {
        print("favorite")
        favoriteImage.isUserInteractionEnabled = false
        if let favorited = tweet.favorited {
            if favorited {
                APIManager.shared.unFavorite(tweet, completion: { (tweet, error) in
                    if let error = error {
                        self.favoriteImage.isUserInteractionEnabled = true
                        print(error.localizedDescription)
                    } else {
                        self.favoriteImage.isUserInteractionEnabled = true
                        self.tweet = tweet
                    }
                })
                favoriteImage.image = #imageLiteral(resourceName: "favor-icon-red")
            } else {
                APIManager.shared.favorite(tweet, completion: { (tweet, error) in
                    if let error = error {
                        self.favoriteImage.isUserInteractionEnabled = true
                        print(error.localizedDescription)
                    } else {
                        self.favoriteImage.isUserInteractionEnabled = true
                        self.tweet = tweet
                    }
                })
                favoriteImage.image = #imageLiteral(resourceName: "favor-icon-red")
            }
        } else {
            APIManager.shared.favorite(tweet, completion: { (tweet, error) in
                if let error = error {
                    self.favoriteImage.isUserInteractionEnabled = true
                    print(error.localizedDescription)
                } else {
                    self.favoriteImage.isUserInteractionEnabled = true
                    self.tweet = tweet
                }
            })
        }
    }
    
    @objc func retweetPost() {
        print("retweet")
        if tweet.retweeted {
            retweetImage.isUserInteractionEnabled = false
            APIManager.shared.unRetweet(tweet, completion: { (tweet, error) in
                if let error = error {
                    self.retweetImage.isUserInteractionEnabled = true
                    print(error.localizedDescription)
                } else {
                    self.retweetImage.isUserInteractionEnabled = true
                }
            })
            retweetImage.image = #imageLiteral(resourceName: "retweet-icon-green")
        } else {
            retweetImage.isUserInteractionEnabled = false
            APIManager.shared.retweet(tweet, completion: { (tweet, error) in
                if let error = error {
                    self.retweetImage.isUserInteractionEnabled = true
                    print(error.localizedDescription)
                } else {
                    self.retweetImage.isUserInteractionEnabled = true
                }
            })
            retweetImage.image = #imageLiteral(resourceName: "retweet-icon-green")
        }
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
