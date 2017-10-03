//
//  AddEditTableViewController.swift
//  Bucket List
//
//  Created by dly on 10/3/17.
//  Copyright © 2017 dly. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    
    weak var delegate: AddEditTableViewControllerDelegate?
    
    //Passed in data via segue from BucketListTableViewController
    var callingSegue: String?
    var item: String?
    var indexPath: IndexPath?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if (itemTextField.text != "") {
            delegate?.doneButtonPressed(by: self, newItem: itemTextField.text!, at: indexPath)
        } else {
            print("Need to enter new item")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Prepopulate text field when editing
        itemTextField.text = item
        
        //Set title
        if callingSegue == "editSegue" {
            self.title = "Edit"
        } else {
            self.title = "Add"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
