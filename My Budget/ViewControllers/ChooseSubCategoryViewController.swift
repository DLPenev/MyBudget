//
//  ChooseSubCategoryViewController.swift
//  My Budget
//
//  Created by MacUSER on 8.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class ChooseSubCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var subCategoryTableVIew: UITableView! 
    
    let subCategoryCellId = "subCategoryId"
    
    var selectedCategory: Int!
    var subcategoriesArray: [String]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subcategoriesArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = subCategoryTableVIew?.dequeueReusableCell(withIdentifier: subCategoryCellId) as? SubCategoryTableViewCell {
            cell.subCategoryLabel.text     = subcategoriesArray[indexPath.row]
//            cell.categoryIconView.image = allCategoryesArray[indexPath.row].categoryIcon
//            cell.categoryIconView.backgroundColor = allCategoryesArray[indexPath.row].categoryColor
            return cell
        }
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
      subcategoriesArray = DBManager.singleton.loadSubCategories(categoryId: selectedCategory+1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
