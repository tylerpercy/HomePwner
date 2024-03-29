//
//  ItemsViewController.swift
//  HomePwner
//
//  Created by Tyler Percy on 3/18/19.
//  Copyright © 2019 Tyler Percy. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    //Function addNewItem: A button on the main storyboard will create a
    //                     new item each time it is pressed
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        // Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    //This function maintains the number of rows in the tableview
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }

    //This function creates a randomly generated object and adds it to the tableview
    //The object is put in its own cell which has a name, serial number, and price
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        if indexPath.row < itemStore.allItems.count {
            let item = itemStore.allItems[indexPath.row]
            
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
            //Transparency so you can still see the dog in the background after cells are added
            cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
            //Color prices based on expense
            if item.valueInDollars < 50 {
                cell.valueLabel.textColor =
                    UIColor(red: 64/255, green: 155/255, blue: 0/255, alpha: 1.0)
            } else {
                cell.valueLabel.textColor =
                    UIColor(red: 201/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }
            return cell
        //This is to add the unique "No More Items!" cell to the bottom
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle .default, reuseIdentifier: "UITableViewCell_NMI")
            cell.textLabel?.text = "No more Items!"
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
            return cell
        }
    }
    
    //Disallows editing the "No More Items!" cell
    //: Chapter 11 Silver
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row >= itemStore.allItems.count){
            return false
        }
        return true
    }
    
    //This function allows you to swap the location of cells in the tableview
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    //This function disallows swapping cells below the "No More Items!" cell
    //: Chapter 11 Gold
    override func tableView(_ tableView: UITableView,
                            targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                            toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if (proposedDestinationIndexPath.row >= itemStore.allItems.count){
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    //This function is in charge of deleting and confirming the deletion of a cell
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Remove \(item.name)?"
            let message = "Are you sure you want to remove this item?"
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive,
                                             handler: { (action) -> Void in
                // Remove the item from the store
                self.itemStore.removeItem(item)
                self.imageStore.deleteImage(forKey: item.itemKey)
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
        ac.addAction(deleteAction)
        
        // Present the alert controller
        present(ac, animated: true, completion: nil)
        }
    }
    
    //renaming the swipe-to-delete button
    //: Chapter 11 Bronze
    override func tableView(_ tableView: UITableView,
                            titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController
                    = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
    
            } default:
                preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        let backgroundImage = UIImage(named: "welcome.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
        tableView.backgroundColor = .lightGray
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.reloadData()
    }
}
