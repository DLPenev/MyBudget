//
//  ChooseCategoryViewController.swift
//  My Budget
//
//  Created by MacUSER on 5.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class ChooseCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var categoriesTableView: UITableView!
 
    let numberOfCategories = 10
    var categoryIndex: Int?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = categoriesTableView?.dequeueReusableCell(withIdentifier: categoryCellId) as? CategoryViewCell {
            cell.categoryLabel.text     = allCategoryesArray[indexPath.row].categoryFullName
            cell.categoryIconView.image = allCategoryesArray[indexPath.row].categoryIcon
            cell.categoryIconView.backgroundColor = allCategoryesArray[indexPath.row].categoryColor
            return cell
        }
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryIndex = indexPath.row
        performSegue(withIdentifier: segueToSubCategory, sender: nil)
        categoriesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == segueToSubCategory{
            let destination = segue.destination as? ChooseSubCategoryViewController
            destination?.selectedCategory = categoryIndex
        }
    }

}
