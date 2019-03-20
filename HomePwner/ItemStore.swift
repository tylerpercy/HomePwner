//
//  ItemStore.swift
//  HomePwner
//
//  Created by Tyler Percy on 3/18/19.
//  Copyright © 2019 Tyler Percy. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.insert(newItem, at: 0)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }

        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        // Remove item from array
        allItems.remove(at: fromIndex)
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    /*
    init() {
        let noMoreItems = Item(random: false)
        noMoreItems.name = "No More Items!"
        noMoreItems.valueInDollars = 0
        allItems.append(noMoreItems)
    }
    */
}


