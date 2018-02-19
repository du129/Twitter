//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jonathan Du on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit


class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var charactersLabel: UILabel!
    
    
    var tweet: Tweet!
    @IBAction func tweetButton(_ sender: Any) {
        APIManager.shared.composeTweet(with: textView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                //delegate?.did(post: tweet)
                self.dismiss(animated: true, completion: nil)
                print("Compose Tweet Success!")
            }
        }
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        let characterLimit = 140
        let total = characterLimit - textView.text.count

        charactersLabel.text = "\(total)"

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
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
