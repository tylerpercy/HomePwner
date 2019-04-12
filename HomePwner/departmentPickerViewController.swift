//
//  DepartmentPickerViewController.swift
//  HomePwner
//
//  Created by Tyler Percy on 4/12/19.
//  Copyright © 2019 Tyler Percy. All rights reserved.
//

import UIKit

class DepartmentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var departmentPickerView: UIPickerView!
    var item: Item!
    
    var departments = [Department]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments.count
    }
    
    private func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(departments[row].rawValue)
        return departments[row].rawValue
    }
    
    override func viewDidLoad() {
        self.departmentPickerView.delegate = self
        self.departmentPickerView.dataSource = self
        
        departments = [Department.Automotive, Department.Furniture, Department.Grocery,
                       Department.Pharmacy, Department.SportingGoods]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.department = departments[departmentPickerView.selectedRow(inComponent: 0)]
    }
}
