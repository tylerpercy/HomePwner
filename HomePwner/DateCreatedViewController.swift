//
//  DateCreatedViewController.swift
//  HomePwner
//
//  Created by Tyler Percy on 3/31/19.
//  Copyright © 2019 Tyler Percy. All rights reserved.
//

import UIKit

//: Chapter 14 Gold
class DateCreatedViewController: UIViewController {
    var datePicker: UIDatePicker!
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Date Created"
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePicker)
        
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
}
