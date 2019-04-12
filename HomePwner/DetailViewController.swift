//
//  DetailViewController.swift
//  HomePwner
//
//  Created by Tyler Percy on 3/31/19.
//  Copyright © 2019 Tyler Percy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate,
        UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: CustomTextField!
    @IBOutlet var serialNumberField: CustomTextField!
    @IBOutlet var valueField: CustomTextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var departmentLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        // If the device has a camera, take a picture; otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            //: Chapter 15 Gold
            let crosshair = UIButton(type: .contactAdd)
            crosshair.tintColor = UIColor.white
            crosshair.translatesAutoresizingMaskIntoConstraints = false
            imagePicker.cameraOverlayView?.addSubview(crosshair)
            imagePicker.cameraOverlayView?.isUserInteractionEnabled = false
            crosshair.centerXAnchor.constraint(equalTo:
                (imagePicker.cameraOverlayView?.centerXAnchor)!).isActive = true
            crosshair.centerYAnchor.constraint(equalTo:
                (imagePicker.cameraOverlayView?.centerYAnchor)!).isActive = true
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    //: Chapter 15 Silver
    @IBAction func removeImage(_ sender: UIBarButtonItem) {
        imageStore.deleteImage(forKey: item.itemKey)
        imageView.image = nil
    }
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    var itemsViewController: ItemsViewController!
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageStore.setImage(image, forKey: item.itemKey)
        // Put that image on the screen in the image view
        imageView.image = image
        // Take image picker off the screen -
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "changeDate"?:
            let dateCreatedViewController = segue.destination as! DateCreatedViewController
            dateCreatedViewController.item = item
        case "changeDepartment"?:
            let departmentPickerViewController = segue.destination as! DepartmentPickerViewController
            departmentPickerViewController.item = item
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        departmentLabel.text = item.department.rawValue
        
        let key = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clear first responder
        view.endEditing(true)
        if (nameField.text == "" || valueField.text == nil) {
            //FIXME: DOESNT DELETE NEWLY CREATED ROW IF INFO NOT GIVEN
            print("Unable to save - Ensure user has entered a valid Name and Value")
        } else {
        // "Save" changes to item
            print("You got here")
            item.name = nameField.text ?? ""
            item.serialNumber = serialNumberField.text
            if let valueText = valueField.text,
                let value = numberFormatter.number(from: valueText) {
                item.valueInDollars = value.intValue
            } else {
                item.valueInDollars = 0
            }
        }
    }
    
    //: Chapter 14 Bronze
    override func viewDidLoad() {
        valueField.keyboardType = .numberPad
    }
    
    //: Chapter 14 Gold
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}


