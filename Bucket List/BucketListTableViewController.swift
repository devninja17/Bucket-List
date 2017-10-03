//
//  BucketListTableViewController.swift
//  Bucket List
//
//  Created by dly on 10/3/17.
//  Copyright © 2017 dly. All rights reserved.
//

import UIKit
import CoreData


class BucketListTableViewController: UITableViewController, AddEditTableViewControllerDelegate {
    
    //An instnace items object of the BucketListItem class and scratchpad
    var items = [BucketListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //Build rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //Build each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    //Detect accessory button tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
    //Detect when a row is clicked/selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected")
    }
    //Segue and data passing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddEditTableViewController
        controller.delegate = self
        
        if (segue.identifier == "editSegue") {
            let indexPath = sender as! IndexPath
            let item = items[indexPath.row].text
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
            //Update Item (edit)
            let item = items[ip.row]
            item.text = newItem
        } else {
            //Add Item
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = newItem
            items.append(item)
        }
        //Save the scratchpad changes to database
        do {
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    //Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //Removing from scratchpad
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        //Save the scratchpad changes to database
        do {
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        
        //Removing from items object
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    //Get all the persistent data from CoreData and set it to the instance object items
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        }
        catch {
            print("\(error)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set title
        self.title = "Bucket List"
        fetchAllItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
