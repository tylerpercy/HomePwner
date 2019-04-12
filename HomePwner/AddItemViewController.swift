//
//  AddItemViewController.swift
//  HomePwner
//
//  Created by Tyler Percy on 4/10/19.
//  Copyright © 2019 Tyler Percy. All rights reserved.
//

/*
import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate,
        UIPickerViewDelegate, UIPickerViewDataSource {
  
    var itemStore: ItemStore!
    var itemsViewController: ItemsViewController!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var departmentPickerView: UIPickerView!

    var departments = [Department]()

    @IBAction func addItemClicked(_ sender: UIButton) {
        let name: String = nameTextField.text!
        let serial: String = serialTextField.text!
        let value: Int = Int(valueTextField.text!) ?? 0
        let department: Department = departments[departmentPickerView.selectedRow(inComponent: 0)]
        print(name)
        print(serial)
        print(value)
        print(department)
        let newItem = itemStore.createItem(name: name, serial: serial, value: value, department: department)
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            //Insert this new row into the table
            itemsViewController.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        self.nameTextField.delegate = self
        self.serialTextField.delegate = self
        self.valueTextField.delegate = self
        self.departmentPickerView.delegate = self
        self.departmentPickerView.dataSource = self
        
        departments = [Department.Automotive, Department.Furniture, Department.Grocery,
         Department.Pharmacy, Department.SportingGoods]
    }
    
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
}

*/

