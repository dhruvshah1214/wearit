//
//  SavedTableViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit

class SavedTableViewController: UITableViewController {
    
    
    var savedItems = [Save]()
    var newSave: Save?
    override func viewDidLoad() {
        super.viewDidLoad()
        savedItems = unarchive() ?? []
        if let _newSave = newSave{
            savedItems.append(_newSave)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        _ = archive(objects: savedItems)
    }
    
    /*private func saveToUserDefaults(save: Save, key: String){
     let userDefauts = UserDefaults.standard
     userDefauts.set(NSKeyedArchiver.archivedData(withRootObject: save), forKey: key)
     }
     
     private func loadFromUserDefaults(key: String) -> Save{
     let userDefauts = UserDefaults.standard
     let data = userDefauts.value(forKey: key) as! NSData
     let save = (NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! Save)
     return save
     }*/
    
    func archive(objects: [Any])->Bool{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        let path = documentDirectory.appending("ObjectData.plist")
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)){
            if let bundlePath = Bundle.main.path(forResource: "ObjectData", ofType: "plist"){
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }catch{
                    print("problem copying")
                }
            }
        }
        let success = NSKeyedArchiver.archiveRootObject(objects, toFile: path)
        return success
    }
    
    
    func unarchive()->[Save]?{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        let path = documentDirectory.appending("ObjectData.plist")
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)){
            if let bundlePath = Bundle.main.path(forResource: "ObjectData", ofType: "plist"){
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }catch{
                    print("problem copying")
                }
            }
        }
        if let objects = NSKeyedUnarchiver.unarchiveObject(withFile: path){
            if let saves = objects as? [Save]{
                return saves
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath)
        
        if let saveCell = cell as? SaveTableViewCell{
            saveCell.save = savedItems[indexPath.row]
        }
        
        return cell
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
