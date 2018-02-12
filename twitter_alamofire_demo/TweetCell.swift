//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import DateToolsSwift
class TweetCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var displayedNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!

    //var delegate: ComposeViewControllerDelegate?

    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            displayedNameLabel.text = tweet.user.name
            retweetLabel.text = "\(String(tweet.retweetCount))"
            favoriteLabel.text = "\(String(describing: tweet.favoriteCount!))"
            dateLabel.text = tweet.createdAtString
            usernameLabel.text = "@\(tweet.user.screenName)"
            profileImageView.af_setImage(withURL: URL(string: tweet.imageURL)!)
            profileImageView.layer.cornerRadius = 16
            profileImageView.clipsToBounds = true
            
            if let favoriteCount = tweet.favoriteCount {
                favoriteLabel.text = "\(favoriteCount)"
            }
            if let favorited = tweet.favorited, favorited {
                favoriteImageView.image = UIImage(named: "favor-icon-red")
            } else {
                favoriteImageView.image = UIImage(named: "favor-icon")
            }
            
            if tweet.retweeted {
                retweetImageView.image = UIImage(named: "retweet-icon-green")
            } else {
                retweetImageView.image = UIImage(named: "retweet-icon")
            }
            retweetImageView.isUserInteractionEnabled = true
            favoriteImageView.isUserInteractionEnabled = true
            retweetImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(retweetPost)))
            favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoritePost)))
  
        }
    }
    
    @objc func favoritePost() {
        print("favorite")
        favoriteImageView.isUserInteractionEnabled = false
        if let favorited = tweet.favorited {
            if favorited {
                APIManager.shared.unFavorite(tweet, completion: { (tweet, error) in
                    if let error = error {
                        self.favoriteImageView.isUserInteractionEnabled = true
                        print(error.localizedDescription)
                    } else {
                        self.favoriteImageView.isUserInteractionEnabled = true
                        self.tweet = tweet
                    }
                })
                favoriteImageView.image = #imageLiteral(resourceName: "favor-icon-red")
            } else {
                APIManager.shared.favorite(tweet, completion: { (tweet, error) in
                    if let error = error {
                        self.favoriteImageView.isUserInteractionEnabled = true
                        print(error.localizedDescription)
                    } else {
                        self.favoriteImageView.isUserInteractionEnabled = true
                        self.tweet = tweet
                    }
                })
                favoriteImageView.image = #imageLiteral(resourceName: "favor-icon-red")
            }
        } else {
            APIManager.shared.favorite(tweet, completion: { (tweet, error) in
                if let error = error {
                    self.favoriteImageView.isUserInteractionEnabled = true
                    print(error.localizedDescription)
                } else {
                    self.favoriteImageView.isUserInteractionEnabled = true
                    self.tweet = tweet
                }
            })
        }
    }
    
    @objc func retweetPost() {
        print("retweet")
        if tweet.retweeted {
            retweetImageView.isUserInteractionEnabled = false
            APIManager.shared.unRetweet(tweet, completion: { (tweet, error) in
                if let error = error {
                    self.retweetImageView.isUserInteractionEnabled = true
                    print(error.localizedDescription)
                } else {
                    self.retweetImageView.isUserInteractionEnabled = true
                }
            })
            retweetImageView.image = #imageLiteral(resourceName: "retweet-icon-green")
        } else {
            retweetImageView.isUserInteractionEnabled = false
            APIManager.shared.retweet(tweet, completion: { (tweet, error) in
                if let error = error {
                    self.retweetImageView.isUserInteractionEnabled = true
                    print(error.localizedDescription)
                } else {
                    self.retweetImageView.isUserInteractionEnabled = true
                }
            })
            retweetImageView.image = #imageLiteral(resourceName: "retweet-icon-green")
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
