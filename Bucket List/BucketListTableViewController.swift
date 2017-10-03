//
//  BucketListTableViewController.swift
//  Bucket List
//
//  Created by dly on 10/3/17.
//  Copyright © 2017 dly. All rights reserved.
//

import UIKit

class BucketListTableViewController: UITableViewController, AddEditTableViewControllerDelegate {
    
    var items = ["Sky diving", "Backpack in Europe"]

    //Build rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //Build each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    //Detect accessory button tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
    //Segue and data passing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddEditTableViewController
        controller.delegate = self
        
        if (segue.identifier == "editSegue") {
            let indexPath = sender as! IndexPath
            let item = items[indexPath.row]
            controller.callingSegue = segue.identifier
            controller.item = item
            controller.indexPath = indexPath
        }
    }
    //Conforming to AddEditTableViewControllerDelegate protocol
    func cancelButtonPressed(by controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonPressed(by controller: UIViewController, newItem: String, at indexPath: IndexPath?) {
        dismiss(animated: true, completion: nil)
        
        if let ip = indexPath {
            items[ip.row] = newItem
        } else {
            items.append(newItem)
        }
        tableView.reloadData()
    }
    //Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set title
        self.title = "Bucket List"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
