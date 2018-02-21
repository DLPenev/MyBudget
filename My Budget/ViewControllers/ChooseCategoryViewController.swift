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
    var categoryIndex      = Int()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = allCategoryesArray[indexPath.row]
        
        if let cell = categoriesTableView?.dequeueReusableCell(withIdentifier: globalIdentificators.categoryCellId) as? CategoryViewCell {
            cell.categoryLabel.text     = category.categoryFullName
            cell.categoryIconView.image = category.categoryIcon
            cell.categoryIconView.backgroundColor = category.categoryColor
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
        self.categoryIndex = indexPath.row
        performSegue(withIdentifier: globalIdentificators.segueToSubCategory, sender: nil)
        categoriesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == globalIdentificators.segueToSubCategory{
            let destination = segue.destination as? ChooseSubCategoryViewController
            destination?.selectedCategory = self.categoryIndex
        }
    }

}
