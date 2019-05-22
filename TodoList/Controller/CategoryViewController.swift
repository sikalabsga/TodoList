//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Nyman Sikazwe on 5/17/19.
//  Copyright © 2019 Nyman Sikazwe. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Add yet"

        return cell
    }
    
    //MARK: - TabkeView delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    

    // MARK: - Table View Data manipulation methods
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories(){
        
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //create alert
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        //create alert action
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
    
            
            self.save(category: newCategory)

            
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new category"
            
            
        }
        
        present(alert, animated: true, completion: nil)
    }
}
