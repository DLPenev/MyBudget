//
//  OverviewViewController.swift
//  My Budget
//
//  Created by MacUSER on 17.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var OverviewTableView:   UITableView!
    @IBOutlet var emogiImageView:      UIImageView!
    @IBOutlet var budgetStatusLabel:   UILabel!
    @IBOutlet var remainingValueLabel: UILabel!
    
    let expenseRepresentCellId = "expenseRepresentCellId"
    
    var segmentIndex = 0
    var allExpenses:       [Expense] = []
    var todayExpenses:     [Expense] = []
    var thisWeekExpenses:  [Expense] = []
    var thisMonthExpenses: [Expense] = []
    var listOfExpensesByCategory: [SumExpense] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  listOfExpensesByCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = OverviewTableView?.dequeueReusableCell(withIdentifier: expenseRepresentCellId) as? ExpenseRepresentOverviewCell {
            cell.categoryNameLabel.text  = listOfExpensesByCategory[indexPath.row].categoryFullName
            cell.categoryIconImageView.image = listOfExpensesByCategory[indexPath.row].categoryIcon
            cell.categoryIconImageView.backgroundColor = listOfExpensesByCategory[indexPath.row].categoryColor
            cell.procentOfTotalExpenceLabel.text = "\(String(listOfExpensesByCategory[indexPath.row].procentOfTotalExpense)) %"
            cell.valueOfExpenseLabel.text = String(listOfExpensesByCategory[indexPath.row].value)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        emogiImageView.image     = #imageLiteral(resourceName: "emojiGood")
        budgetStatusLabel.text   = "Status is good"
        remainingValueLabel.text = "34 remaining"
        allExpenses = DBManager.singleton.loadExpenses()
        todayExpenses     = []
        thisWeekExpenses  = []
        thisMonthExpenses = []
        listOfExpensesByCategory = []
        sortExpenseByPeriod()
        
        listOfExpensesByCategory = getExpensesByCategory(period: todayExpenses)
        OverviewTableView.reloadData()
    }

    
    

    
    func sortExpenseByPeriod(){
        
        for expense in allExpenses {
            let expenseDay  = calendar.component(.day , from: Date(milliseconds: Int(expense.date)))
            let expenseWeek = calendar.component(.weekOfYear, from: Date(milliseconds: Int(expense.date)))
            let expenseMonth = calendar.component(.month, from: Date(milliseconds: Int(expense.date)))
           
            if expenseDay == today {
                todayExpenses.append(expense)
            }
            
            if expenseWeek == thisWeek {
                thisWeekExpenses.append(expense)
            }
            
            if expenseMonth == thisMonth {
                thisMonthExpenses.append(expense)
            }
        }
    }
    
    func getExpensesByCategory(period: [Expense])->[SumExpense]{
        
        
        
        var foodExpenses = 0.0
        var shopingExpenses = 0.0
        var housingExpenses = 0.0
        var transportationExpenses = 0.0
        var vehicleExpenses = 0.0
        var lifeExpenses = 0.0
        var communictionExpenses = 0.0
        var financialExpenses = 0.0
        var investmentExpenses = 0.0
        var othersExpenses = 0.0
        
        for expense in period {
            switch expense.categoryId {
                case 1: foodExpenses += expense.value
                case 2: shopingExpenses += expense.value
                case 3: housingExpenses += expense.value
                case 4: transportationExpenses += expense.value
                case 5: vehicleExpenses += expense.value
                case 6: lifeExpenses += expense.value
                case 7: communictionExpenses += expense.value
                case 8: financialExpenses += expense.value
                case 9: investmentExpenses += expense.value
            default: othersExpenses += expense.value
            }
        }
        
        let totalExpenses = foodExpenses + shopingExpenses + housingExpenses + transportationExpenses + vehicleExpenses + lifeExpenses + communictionExpenses + financialExpenses + investmentExpenses + othersExpenses
        
        let arrayOfSumExpenseValues = [foodExpenses, shopingExpenses, housingExpenses, transportationExpenses, vehicleExpenses, lifeExpenses, communictionExpenses, financialExpenses, investmentExpenses, othersExpenses]
        
        var arrayOfSumExpense: [SumExpense] = []
        
        var counter = 0
        
        for expenceValue in arrayOfSumExpenseValues {
            if expenceValue != 0.0 {
                let procentOfTotal = expenceValue / totalExpenses * 100
                arrayOfSumExpense.append(SumExpense(categoryIcon: allCategoryesArray[counter].categoryIcon, categoryColor: allCategoryesArray[counter].categoryColor, categoryFullName: allCategoryesArray[counter].categoryFullName, value: expenceValue, procentOfTotalExpense: Int(procentOfTotal)))
            }
            counter += 1
        }
        
        
//
//        if foodExpenses != 0.0 {
//            let procentOfTotal = foodExpenses / totalExpenses * 100
//            arrayOfSumExpense.append(SumExpense(categoryIcon: allCategoryesArray[0].categoryIcon, categoryColor: allCategoryesArray[0].categoryColor, categoryFullName: allCategoryesArray[0].categoryFullName, value: foodExpenses, procentOfTotalExpense: Int(procentOfTotal)))
//        }
//        if shopingExpenses != 0.0 {
//            let procentOfTotal = shopingExpenses / totalExpenses * 100
//            arrayOfSumExpense.append(SumExpense(categoryIcon: allCategoryesArray[1].categoryIcon, categoryColor: allCategoryesArray[1].categoryColor, categoryFullName: allCategoryesArray[1].categoryFullName, value: foodExpenses, procentOfTotalExpense: Int(procentOfTotal)))
//        }
        return arrayOfSumExpense
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        segmentIndex = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 0 {
            listOfExpensesByCategory = getExpensesByCategory(period: todayExpenses)
        } else if sender.selectedSegmentIndex == 1 {
            listOfExpensesByCategory = getExpensesByCategory(period: thisWeekExpenses)
        } else {
            listOfExpensesByCategory = getExpensesByCategory(period: thisMonthExpenses)
        }
        
        OverviewTableView.reloadData()
    }
    
    @IBAction func addIncomePressed(_ sender: UIButton) {
       
    }
    
}
