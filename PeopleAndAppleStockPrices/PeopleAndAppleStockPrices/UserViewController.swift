//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    //my varibles
     var users = [UserInfo](){
        didSet {
            myUsersTableView.reloadData()
        }
    }
    
    
    //Outlets
    @IBOutlet weak var myUsersTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "People 👨🏾"
    users = loadPeopleData()
    myUsersTableView.dataSource = self
    searchBar.delegate = self
    
  }
   func loadPeopleData() -> [UserInfo]{
    var results = [UserInfo]()
    if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
        let myUrl = URL(fileURLWithPath: path)
        if let data = try? Data.init(contentsOf: myUrl){
            do {
                let thesePeople = try JSONDecoder().decode(UserInfo.SearchPeopleData.self, from: data)
               results = thesePeople.results
                print("there are \(users.count) people")
            } catch {
                print(error)
            }
        }
    }
    return results
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController, let indexPath = myUsersTableView.indexPathForSelectedRow else {
            fatalError("Error in the Segue")
        }
        destination.usersIExpect = users[indexPath.row]
    }

}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myUsersTableView.dequeueReusableCell(withIdentifier: "pplCell", for: indexPath)
        let usersToSet = users[indexPath.row]
        cell.textLabel?.text = "\(usersToSet.name.first) \(usersToSet.name.last)"
        cell.detailTextLabel?.text = usersToSet.location.city
        return cell
    }
    
    
}

extension UserViewController: UISearchBarDelegate{
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true
//    }
//    //searchBarTextDidEndEditing - Tells the delegate that the user finished editing the search text. Typically, you implement this method to perform the text-based search
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false
//
//    }
//    //searchBarCancelButtonClicked - Tells the delegate that the cancel button was tapped. Typically, you implement this method to dismiss the search bar.
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchActive = false
//    }
//    //searchBarSearchButtonClicked - Tells the delegate that the search button was tapped. You should implement this method to begin the search. Use the text property of the search bar to get the text. You can also send becomeFirstResponder() to the search bar to begin editing programmatically.
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchActive = false
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        users = loadPeopleData()
        if searchText == "" {
            return
        } else {
            users = loadPeopleData().filter{$0.name.first.lowercased().contains(searchText.lowercased())}

        }
    }
    
   
}
