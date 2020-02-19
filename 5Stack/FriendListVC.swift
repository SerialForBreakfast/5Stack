//
//  ViewController.swift
//  5Stack
//
//  Created by Joseph McCraw on 2/19/20.
//  Copyright © 2020 Joseph McCraw. All rights reserved.
//

import UIKit

class FriendListVC: UITableViewController {

    var friends = [Friend]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        title = "5Stack Friends"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.timeZone.identifier
        return cell
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        
        guard let savedData = defaults.data(forKey: "Friends") else { return }
        
        let decoder = JSONDecoder()
        
        guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else { return }
        
        friends = savedFriends
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let savedData = try? encoder.encode(friends) else {
            fatalError("Unable to encode JSON for friends to userdefaults")
        }
        defaults.set(savedData, forKey: "Friends")
        
    }
    
    
    @objc func addFriend() {
        let friend = Friend()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
    }
    
}

