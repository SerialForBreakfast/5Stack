//
//  ViewController.swift
//  5Stack
//
//  Created by Joseph McCraw on 2/19/20.
//  Copyright © 2020 Joseph McCraw. All rights reserved.
//

import UIKit

class FriendListVC: UITableViewController, StoryBoarded {

    var friends = [Friend]()
    var selectedFriend: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        title = "5Stack"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timeZone
        dateFormatter.timeStyle = .short
        
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editFriend(friend: friends[indexPath.row], position: indexPath.row)
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
        editFriend(friend: friend, position: friends.count - 1)

    }
    
    func editFriend(friend: Friend, position: Int) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FriendEditVC") as? FriendEditVC else  {
            fatalError()
        }
        selectedFriend = position
        vc.delegate = self
        vc.friend = friend
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateFriend(friend: Friend) {
        guard let selectedFriend = selectedFriend else { return }
        friends[selectedFriend] = friend
        tableView.reloadData()
        saveData()
    }
}

