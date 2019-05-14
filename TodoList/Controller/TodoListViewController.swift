//
//  ViewController.swift
//  TodoList
//
//  Created by Nyman Sikazwe on 5/11/19.
//  Copyright © 2019 Nyman Sikazwe. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //array for table items
    var itemArray = [Item]()
    
    //create a database object
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Shopping"
        
        let newItem2 = Item()
        newItem2.title = "Programming"
        
        let newItem3 = Item()
        newItem3.title = "Exercising"
        
        itemArray.append(newItem)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
        //retrieve data from a database and save it into an array
        
         if let items  = defaults.object(forKey: "TodoListArray") as? [Item]{
         itemArray = items
         }
 
        
        
        
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        //ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK - TableView delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        //add check mark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        //UI alert pop up
        let alert = UIAlertController(title: "Add New TodoList Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks the add button on UIAlert
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            //Persist data to a database
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //reload data
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

