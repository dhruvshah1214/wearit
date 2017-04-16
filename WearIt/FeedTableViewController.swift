//
//  FeedTableViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage

class FeedTableViewController: UITableViewController {
    
    var posts: [Post] = [Post]()
    var ref = FIRDatabase.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.pullInfo();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        if let postCell = cell as? PostTableViewCell{
            postCell.post = posts[indexPath.row]
        }

        return cell
    }
    

    func pullInfo(){
        //var post = Post(
        let storage = FIRStorage.storage()
        let storageRef = storage.reference()
        
        ref.child("Users").observeSingleEvent(of: .value, with: { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                self.ref.child("Users").child(rest.key).child("Posts").observeSingleEvent(of: .value, with: { snapshot1 in
                    let enuma = snapshot1.children
                    while let res = enuma.nextObject() as? FIRDataSnapshot {
                        var clothe : String?
                        var description : String?
                        var likes : Int?
                        var username : String?
                        var pic : UIImage?
                        var profile : UIImage?
                        self.ref.child("Users").child(rest.key).child("Posts").child(res.key).child("Clothing").observeSingleEvent(of: .value, with: { (snapshot2) in
                            // Get user value
                            clothe = snapshot2.value as? String
                            self.ref.child("Users").child(rest.key).child("Posts").child(res.key).child("Description").observeSingleEvent(of: .value, with: { (snapshot3) in
                                // Get user value
                                description = snapshot3.value as? String
                                self.ref.child("Users").child(rest.key).child("Posts").child(res.key).child("Likes").observeSingleEvent(of: .value, with: { (snapshot4) in
                                    // Get user value
                                    likes = snapshot4.value as? Int
                                    self.ref.child("Users").child(rest.key).child("ID").observeSingleEvent(of: .value, with: { (snapshot5) in
                                        // Get user value
                                        username = snapshot5.value as? String
                                        print(username!)
                                        var isrString = "Users/" + username! + "/Posts/" + description! + ".png"
                                        print(isrString)
                                        let islandRef = storageRef.child(isrString)
                                        
                                        islandRef.data(withMaxSize: 32 * 1024 * 1024) { data, error in
                                            if let err = error {
                                                // Uh-oh, an error occurred!
                                                print(err.localizedDescription)
                                            } else {
                                                
                                                pic = UIImage(data: data!)
                                                let islandRefe = storageRef.child("Users/" + username! + "/profilePicture.png")
                                                
                                                islandRefe.data(withMaxSize: 32 * 1024 * 1024) { data1, error2 in
                                                    if let er2 = error2 {
                                                        // Uh-oh, an error occurred!
                                                    } else {
                                                        
                                                        profile = UIImage(data: data1!)
                                                        var post = Post(_image: pic!, _user: username!, _numOfLikes: likes!, _articlesOfClothing: [URL(string: clothe!)!], _description: description!, _profileImage: profile!, _postID: Int(String(res.key))!, _userID: rest.key)
                                                        self.posts.append(post)
                                                        self.tableView.reloadData()
                                                    }
                                                }
                                                
                                                
                                                
                                                
                                            }
                                        }
                                        
                                        
                                        

                                    })
                                })
                            })
                        })
                        
                        
                        
                  
                        
                     }
                })
            }
        })
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
