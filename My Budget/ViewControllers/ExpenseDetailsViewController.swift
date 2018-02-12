//
//  ExpenseDetailsViewController.swift
//  My Budget
//
//  Created by MacUSER on 24.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class ExpenseDetailsViewController: UIViewController {
    
    @IBOutlet var listOfExpenseForPeriodTableView: UITableView!
    @IBOutlet var titleOutlet: UINavigationItem!
    
    @IBOutlet var headerTableView: UIView!
    @IBOutlet var headerViewCategoryNameLabel: UILabel!
    @IBOutlet var headerCateryIconImageView: UIImageView!
    
    let expensesViewCellId  = "expensesViewCellId"

    var segmentIndex =   Int()
    var expenseList  =  [Expense()]
    var selectedCategory = Category()

    let cellHeight: CGFloat = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setupHeaderView() {
        self.headerViewCategoryNameLabel.text = selectedCategory.categoryFullName
        self.headerViewCategoryNameLabel.textColor = UIColor.white
        self.headerCateryIconImageView.image = selectedCategory.categoryIcon
        self.headerTableView.backgroundColor = selectedCategory.categoryColor
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func presentPopupEdit(expenseIndex: Int){
        let editPopup = storyboard?.instantiateViewController(withIdentifier: globalIdentificators.popupControllerId) as! PopUpViewController
        editPopup.editedExpense = expenseList[expenseIndex]
        editPopup.popupDelegate = self
        present(editPopup, animated: true, completion: nil)
    }
    
}

extension ExpenseDetailsViewController:  UITableViewDelegate, UITableViewDataSource   {       /// table view
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let expense = expenseList[indexPath.row]
        
        if segmentIndex == 0 {
            self.titleOutlet.title = NSLocalizedString(globalStringsKeys.today , comment: "")
            let time = "".getTimeOrDateToString(dateInMillisec: expense.date, format: globalDateFormats.dateFormatTime)
            return createExpenseViewCell(dateOrTime: time, indexPathRow: indexPath.row)
        } else if segmentIndex == 1 {
            self.titleOutlet.title = NSLocalizedString(globalStringsKeys.thisWeek, comment: "")
            let weekday = "".getTimeOrDateToString(dateInMillisec: expense.date, format: globalDateFormats.dateFormatWeekDay)
           return createExpenseViewCell(dateOrTime: weekday, indexPathRow: indexPath.row)

        } else {
            self.titleOutlet.title = NSLocalizedString(globalStringsKeys.thisMonth, comment: "")
            let fullDate = "".getTimeOrDateToString(dateInMillisec: expense.date, format: globalDateFormats.dateFormatFullDate)
            return createExpenseViewCell(dateOrTime: fullDate, indexPathRow: indexPath.row)
        }
    }
    
    func createExpenseViewCell(dateOrTime: String, indexPathRow: Int)->UITableViewCell{
        let expense = expenseList[indexPathRow]
        
        let expenseValue = "".doubleFormater(value: expenseList[indexPathRow].value)
        if let expenseViewCell = listOfExpenseForPeriodTableView.dequeueReusableCell(withIdentifier: expensesViewCellId) as? ExpensesCell {
            expenseViewCell.dayOfWeekLabel.text       = "    \(dateOrTime)"
            expenseViewCell.subcategoryNameLabel.text = expense.subcategoryName
            expenseViewCell.expenseValueLabel.text    = "\(expenseValue) \(globalUserDefaults.userCurrecy)"
            return expenseViewCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editTitle   = NSLocalizedString(globalStringsKeys.buttonEdit, comment: "")
        let deleteTitle = NSLocalizedString(globalStringsKeys.buttonDelete, comment: "")
        
        let edit = UITableViewRowAction(style : .normal, title: editTitle, handler: { action , indexPath in
            print("edit click")

            self.presentPopupEdit(expenseIndex: indexPath.row)
        })
        
        let delete = UITableViewRowAction(style : .destructive, title: deleteTitle, handler: { action , indexPath in
            print("delete touchup inside")

            DBManager.singleton.deleteAttribute(table: globalTableConsts.tableExpenses, attributeID: self.expenseList[indexPath.row].expenseId)
            self.expenseList.remove(at: indexPath.row)
            self.listOfExpenseForPeriodTableView.deleteRows(at: [indexPath], with: .automatic)
            if self.expenseList.count < 1 {
                let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: globalIdentificators.tabBarControllerId) as! TabBarViewController
                tabBarController.selectedViewController = tabBarController.viewControllers?[globalIndexes.overviewViewController]
                self.present(tabBarController, animated: true, completion: nil)
            }
        })
        
        return [delete, edit]
    }
    
}

extension ExpenseDetailsViewController: PopupDelegate {

    func setNewValuesAndRefreshTableView() {
        if self.expenseList.count < 1 {
            dismiss(animated: true)
        } else {
            self.listOfExpenseForPeriodTableView.reloadData()
        }
    }
    
}

