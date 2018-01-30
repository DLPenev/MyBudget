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
    var selectedRowIndex = 0
    var butonIndex = 0
    
    var allExpensesByPeriod: [[Expense]] = [[],[],[]] // allExpensesByPeriod[[today],[thisWeek],[thisMonth]]
    
    var listOfExpensesByCategory: [SumExpense] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  listOfExpensesByCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatedProcent = Global.singleton.doubleFormater(value: listOfExpensesByCategory[indexPath.row].procentOfTotalExpense)
        let formatedValue   = Global.singleton.doubleFormater(value: listOfExpensesByCategory[indexPath.row].value)
        
        if let cell = OverviewTableView?.dequeueReusableCell(withIdentifier: expenseRepresentCellId) as? ExpenseRepresentOverviewCell {
            cell.categoryNameLabel.text  = listOfExpensesByCategory[indexPath.row].categoryFullName
            cell.categoryIconImageView.image = listOfExpensesByCategory[indexPath.row].categoryIcon
            cell.categoryIconImageView.backgroundColor = listOfExpensesByCategory[indexPath.row].categoryColor
            cell.procentOfTotalExpenceLabel.text = "\(formatedProcent) %"
            cell.valueOfExpenseLabel.text = formatedValue
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: segueToExpenseDetails, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNewValuesAndRefreshTableView()
    }

    func sortExpenseByPeriod(){

        for expense in allExpenses {
            let expenseDay  = calendar.component(.day , from: Date(milliseconds: Int(expense.date)))
            let expenseWeek = calendar.component(.weekOfYear, from: Date(milliseconds: Int(expense.date)))
            let expenseMonth = calendar.component(.month, from: Date(milliseconds: Int(expense.date)))
           
            if expenseDay == today {
                allExpensesByPeriod[0].append(expense)
            }
            
            if expenseWeek == thisWeek {
                allExpensesByPeriod[1].append(expense)
            }
            
            if expenseMonth == thisMonth {
                allExpensesByPeriod[2].append(expense)
            }
        }
    }
    
    func getExpensesByCategory()->[SumExpense]{
        
        let period = allExpensesByPeriod[segmentIndex]
        
        var foodExpenses           = 0.0
        var shopingExpenses        = 0.0
        var housingExpenses        = 0.0
        var transportationExpenses = 0.0
        var vehicleExpenses        = 0.0
        var lifeExpenses           = 0.0
        var communictionExpenses   = 0.0
        var financialExpenses      = 0.0
        var investmentExpenses     = 0.0
        var othersExpenses         = 0.0
        
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
                arrayOfSumExpense.append(SumExpense(categoryIcon: allCategoryesArray[counter].categoryIcon, categoryColor: allCategoryesArray[counter].categoryColor, categoryFullName: allCategoryesArray[counter].categoryFullName, value: expenceValue, procentOfTotalExpense: procentOfTotal, categoryPrimaryKey: allCategoryesArray[counter].categoryPK))
            }
            counter += 1
        }
        return arrayOfSumExpense
    }
 
    func getBudgetTotal() ->(today:Double,thisWeek:Double,thisMonth:Double){
        let cashFlow = DBManager.singleton.getCashFlow()
        let regularIncome    = cashFlow.income
        let regularExpense   = cashFlow.expense
        let savingPercentage = cashFlow.savingsPercentage
        let savings          = regularIncome * (savingPercentage * 0.01)
        
        let thisMonth = regularIncome - regularExpense - savings
        let thisWeek  = thisMonth / 4
        let today     = thisMonth / 30
        
        return (today, thisWeek, thisMonth)
    }
    
    func getRemainingAndTotalBalance(period: Int)->(remainder:Double,total:Double){

        let budgetTotal = getBudgetTotal()
        
        var allExpenses = 0.0
        
        if period == 0 {
            for expense in allExpensesByPeriod[0] {
                allExpenses += expense.value
            }
            return ((budgetTotal.today - allExpenses), budgetTotal.today)
        } else if period == 1 {
            for expense in allExpensesByPeriod[1] {
                allExpenses += expense.value
            }
            return (budgetTotal.thisWeek - allExpenses , budgetTotal.thisWeek)
        } else {
            for expense in allExpensesByPeriod[2] {
                allExpenses += expense.value
            }
            return (budgetTotal.thisMonth - allExpenses ,  budgetTotal.thisMonth)
        }
    }
    
    func getBudgetStatus(remainingAndTotalBalance: (total:Double, remainder:Double))->(status: String,emoji: UIImage){

        let oneThirdBudget = remainingAndTotalBalance.total / 3
        let reminder = remainingAndTotalBalance.remainder
        
        if reminder > 2 * oneThirdBudget {
            return statusRich
        } else if reminder > oneThirdBudget {
            return statusGotSome
        } else if reminder < oneThirdBudget && reminder > 0 {
            return statusPoor
        } else {
            return statusBroke
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == segueToPopup{
            let destination = segue.destination as? PopUpViewController
            destination?.popupViewIndex = butonIndex
            destination?.popupDelegate = self
        }
        
        if segue.identifier == segueToExpenseDetails{
            let destination = segue.destination as? ExpenseDetailsViewController
            destination?.segmentIndex  = segmentIndex
            
            let selectedCategoryId = listOfExpensesByCategory[selectedRowIndex].categoryPrimaryKey
            
            var listOfExpenseForSelectedCategoryAndPeriod: [Expense] = []
            for expense in allExpensesByPeriod[segmentIndex] {
                if expense.categoryId == selectedCategoryId {
                    listOfExpenseForSelectedCategoryAndPeriod.append(expense)
                }
            }
            for category in allCategoryesArray {
                if category.categoryPK == selectedCategoryId {
                    destination?.selectedCategory = category
                }
            }
            destination?.expenseList  = listOfExpenseForSelectedCategoryAndPeriod
            
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        segmentIndex = sender.selectedSegmentIndex        
        setNewValuesAndRefreshTableView()
    }
    
    @IBAction func addExpenseTouchUpInside(_ sender: Any) {
        butonIndex = popupIndexExpense
        performSegue(withIdentifier: segueToPopup, sender: nil)
    }
    
    @IBAction func addIncomePressed(_ sender: Int) {
        butonIndex = popupIndexIncome
        performSegue(withIdentifier: segueToPopup, sender: nil)
    }
    
}

extension OverviewViewController: PopupDelegate {

    func setNewValuesAndRefreshTableView() {
        var remainBalance: Double
        var totalBalance: Double

        allExpensesByPeriod = [[],[],[]]
        
        listOfExpensesByCategory = []
        
        allExpenses = DBManager.singleton.loadExpenses()
        sortExpenseByPeriod()
        listOfExpensesByCategory = getExpensesByCategory()
        remainBalance = getRemainingAndTotalBalance(period: segmentIndex).remainder
        totalBalance  = getRemainingAndTotalBalance(period: segmentIndex).total
        remainingValueLabel.text = "Balance :  \(Global.singleton.doubleFormater(value: remainBalance))"
        let budgetStatus = getBudgetStatus(remainingAndTotalBalance: (total: totalBalance, remainder: remainBalance))
        emogiImageView.image     = budgetStatus.emoji
        budgetStatusLabel.text   = budgetStatus.status
        OverviewTableView.reloadData()
    }
    
}





