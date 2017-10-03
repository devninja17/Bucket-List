//
//  AddEditTableViewControllerDelegate.swift
//  Bucket List
//
//  Created by dly on 10/3/17.
//  Copyright © 2017 dly. All rights reserved.
//

import UIKit

protocol AddEditTableViewControllerDelegate: class {
    func cancelButtonPressed(by controller: UIViewController)
    func doneButtonPressed(by controller: UIViewController, newItem: String, at indexPath: IndexPath?)
}
