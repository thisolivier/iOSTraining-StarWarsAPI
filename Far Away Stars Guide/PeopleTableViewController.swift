//
//  ViewController.swift
//  Far Away Stars Guide
//
//  Created by Olivier Butler on 24/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    // Fake data
    var people = ["Please", "Wait", "For", "Star", "People"]
    var result:NSArray?
    var first = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromUrl("https://swapi.co/api/people/")
    }
    
    // Data processing
    func fetchDataFromUrl(_ input_url: String){
        let url = URL(string: input_url)
        let session = URLSession.shared
        if let requestUrl = url {
            let task = session.dataTask(with: requestUrl, completionHandler: fetchCompletionHandler)
            task.resume()
        }
    }
    
    func fetchCompletionHandler(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void{
        print("Session fetch task is running")
        do {
            let jsonConversion = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            if let results = (jsonConversion!["results"] as? NSArray){
                if first {
                    people = []
                    first = false
                }
                for item in results {
                    let name = (item as! NSDictionary)["name"] as! String
                    people.append(name)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if let nextUrl = jsonConversion!["next"] as? String{
                        self.fetchDataFromUrl(nextUrl)
                    }
                }
                
            }
        } catch {
            print("Failure to convert to JSON \(error)")
        }
    }
    
    // Table view setup
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell")
        cell?.textLabel?.text = people[indexPath.row]
        return cell!
    }


}

