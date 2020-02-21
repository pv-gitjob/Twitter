//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Praveen V on 2/20/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var ProfilePictureImageView: UIImageView!
    @IBOutlet weak var ProfileTextView: UITextView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            setFields()
        }
    }
    
    func setFields() {
        let myUrl = "https://api.twitter.com/1.1/users/show.json?screen_name=Praveen31832509"
        //let myUrl = "https://api.twitter.com/1.1/users/show.json?screen_name=" + getScreenName()
        
        TwitterAPICaller.client?.getProfile(url: myUrl, success: { (user: NSDictionary) in

            let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
            let data = try? Data(contentsOf: imageUrl!)
            if let imageData = data {
                self.ProfilePictureImageView.image = UIImage(data: imageData)
            }
            
            let imageUrl2 = URL(string: (user["profile_banner_url"] as? String)!)
            let data2 = try? Data(contentsOf: imageUrl2!)
            if let imageData2 = data2 {
                self.bannerImageView.image = UIImage(data: imageData2)
            }

            var userInformation = ""
            let name = user["name"] as? String ?? ""
            let screenName = user["screen_name"] as? String ?? ""
            let location = user["location"] as? String ?? ""
            let url = user["url"] as? String ?? ""
            let description = user["description"] as? String ?? ""
            let verified = user["verified"] as? Bool ?? false
            let followers = user["followers_count"] as? Int ?? 0
            let friends = user["friends_count"] as? Int ?? 0
            let favorites = user["favorites_count"] as? Int ?? 0
            let statuses = user["statuses_count"] as? Int ?? 0
            let created = user["created_at"] as? String ?? ""
            
            userInformation += "Name: " + name + "\nScreenName: " + screenName + "\nLocation: " + location
                            + "\nUrl: " + url + "\nVerified: " + String(verified) + "\nFollowers: " + String(followers) + "\nFriends: " + String(friends)
                            + "\nFavorites: " + String(favorites) + "\nStatuses: " + String(statuses) + "\nCreated: " + created + "\nDescription: " + description
            
            self.ProfileTextView.text = userInformation
            
        }, failure: { (Error) in
            self.dismiss(animated: true, completion: nil)
        })

        
    }
    
    func getScreenName() -> String {
        
        var screenName = ""
        let myUrl = "https://api.twitter.com/1.1/account/settings.json"
        TwitterAPICaller.client?.getProfile(url: myUrl, success: { (userSettings: NSDictionary) in
            
            screenName = userSettings["screen_name"] as! String
            print(screenName)
            
        }, failure: { (Error) in
            self.dismiss(animated: true, completion: nil)
        })

        return screenName
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
