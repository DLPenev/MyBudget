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

    var segmentIndex:     Int!
    var expenseList:     [Expense]!
    var selectedCategory: Category!

    let cellHeight: CGFloat = 60

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupHeaderView()
        
    }
    
    func setupHeaderView() {
        headerViewCategoryNameLabel.text = selectedCategory.categoryFullName
        headerViewCategoryNameLabel.textColor = UIColor.white
        headerCateryIconImageView.image = selectedCategory.categoryIcon
        headerTableView.backgroundColor = selectedCategory.categoryColor
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func presentPopupEdit(expenseIndex: Int){
        let editPopup = storyboard?.instantiateViewController(withIdentifier: popupControllerId) as! PopUpViewController
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
  
        if segmentIndex == 0 {
            titleOutlet.title = "Today"
            let time = Global.singleton.getTimeOrDateToString(dateInMillisec: expenseList[indexPath.row].date, format: dateFormatTime)
            return createExpenseViewCell(dateOrTime: time, indexPathRow: indexPath.row)
        } else if segmentIndex == 1 {
            titleOutlet.title = "This Week"
            let weekday = Global.singleton.getTimeOrDateToString(dateInMillisec: expenseList[indexPath.row].date, format: dateFormatWeekDay)
           return createExpenseViewCell(dateOrTime: weekday, indexPathRow: indexPath.row)

        } else {
            titleOutlet.title = "This Month"
            let fullDate = Global.singleton.getTimeOrDateToString(dateInMillisec: expenseList[indexPath.row].date, format: dateFormatFullDate)
            return createExpenseViewCell(dateOrTime: fullDate, indexPathRow: indexPath.row)
        }

    }
    
    func createExpenseViewCell(dateOrTime: String, indexPathRow: Int)->UITableViewCell{
        if let expenseViewCell = listOfExpenseForPeriodTableView.dequeueReusableCell(withIdentifier: expensesViewCellId) as? ExpensesCell {
            expenseViewCell.dayOfWeekLabel.text = "    \(dateOrTime)"
            expenseViewCell.subcategoryNameLabel.text = expenseList[indexPathRow].subcategoryName
            expenseViewCell.expenseValueLabel.text = Global.singleton.doubleFormater(value: expenseList[indexPathRow].value)
            return expenseViewCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style : .normal, title: "Edit", handler: { action , indexPath in
            print("edit click")

            self.presentPopupEdit(expenseIndex: indexPath.row)
        })
        
        let delete = UITableViewRowAction(style : .destructive, title: "Delete", handler: { action , indexPath in
            print("delete touchup inside")

            DBManager.singleton.deleteAttribute(table: tableExpenses, attributeID: self.expenseList[indexPath.row].expenseId)
            self.expenseList.remove(at: indexPath.row)
            self.listOfExpenseForPeriodTableView.deleteRows(at: [indexPath], with: .automatic)
            if self.expenseList.count < 1 {
                self.dismiss(animated: true)
            }
        })
        
        return [delete, edit]
    }
    
}


extension ExpenseDetailsViewController: PopupDelegate {
    func setNewValuesAndRefreshTableView() {
        if expenseList.count < 1 {
            dismiss(animated: true)
        } else {
            listOfExpenseForPeriodTableView.reloadData()
        }
    }
    
}

