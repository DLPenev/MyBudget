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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {

//        allExpenses = DBManager.singleton.loadExpenses()
//        todayExpenses     = []
//        thisWeekExpenses  = []
//        thisMonthExpenses = []
//        listOfExpensesByCategory = []
//        sortExpenseByPeriod()
//
//        listOfExpensesByCategory = getExpensesByCategory()
//
//
//        remainingValueLabel.text = String(getRemainingAndTotalBalance(period: segmentIndex).remainder)  //"34 remaining"
//
////        emogiImageView.image     = #imageLiteral(resourceName: "emojiGood")
////        budgetStatusLabel.text   = "Status is good"
//        OverviewTableView.reloadData()
        
        setStatusAndRefreshTableView()
    }


    func sortExpenseByPeriod(){
        todayExpenses = []
        thisWeekExpenses = []
        thisWeekExpenses = []
        
        
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
    
    func getExpensesByCategory()->[SumExpense]{
        
        var period: [Expense]
        
        if segmentIndex == 0 {
            period = todayExpenses
        } else if segmentIndex == 1 {
            period = thisWeekExpenses
        } else {
           period = thisMonthExpenses
        }
        
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
                arrayOfSumExpense.append(SumExpense(categoryIcon: allCategoryesArray[counter].categoryIcon, categoryColor: allCategoryesArray[counter].categoryColor, categoryFullName: allCategoryesArray[counter].categoryFullName, value: expenceValue, procentOfTotalExpense: procentOfTotal))
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
        
        if period == 0 {                         //today
            for i in todayExpenses {
                allExpenses += i.value
            }
            
            return ((budgetTotal.today - allExpenses), budgetTotal.today)
            
        } else if period == 1 {                 //this week
            for i in thisWeekExpenses {
                allExpenses += i.value
            }
            
            return (budgetTotal.thisWeek - allExpenses , budgetTotal.thisWeek)
            
        } else {                                //this month
            for i in thisMonthExpenses {
                allExpenses += i.value
            }
            
            return (budgetTotal.thisMonth - allExpenses ,  budgetTotal.thisMonth)
        }
    }
    
    func getBudgetStatus(remainingAndTotalBalance: (total:Double, remainder:Double))->(status: String,emoji: UIImage){
        //ремайнинг баланса който идва вече е за определен период
         //tova da e tupyl da idva kato argument i da dyrji ostatyka i totala za iskaniq period
        
       
            let oneThirdbudget = remainingAndTotalBalance.total / 3
            
            if remainingAndTotalBalance.remainder > 2 * oneThirdbudget {
                return statusRich
            } else if remainingAndTotalBalance.remainder > oneThirdbudget {
                return statusGotSome
            } else if remainingAndTotalBalance.remainder < oneThirdbudget && remainingAndTotalBalance.remainder > 0 {
                return statusPoor
            } else {
                return statusBroke
            }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == segueToPopup{
            let destination = segue.destination as? PopUpViewController
            destination?.myDelegate = self
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        segmentIndex = sender.selectedSegmentIndex        
        setStatusAndRefreshTableView()
    }
    
    @IBAction func addIncomePressed(_ sender: UIButton) {
       
    }
    
}

extension OverviewViewController: testProtocol {
    func setStatusAndRefreshTableView() {
        var remainBalance: Double
        var totalBalance: Double
        
        
        todayExpenses     = []
        thisWeekExpenses  = []
        thisMonthExpenses = []
        listOfExpensesByCategory = []
        
        allExpenses = DBManager.singleton.loadExpenses()
        sortExpenseByPeriod()
        listOfExpensesByCategory = getExpensesByCategory()
        remainBalance = getRemainingAndTotalBalance(period: segmentIndex).remainder
        totalBalance  = getRemainingAndTotalBalance(period: segmentIndex).total
        remainingValueLabel.text = Global.singleton.doubleFormater(value: remainBalance)
        let budgetStatus = getBudgetStatus(remainingAndTotalBalance: (total: totalBalance, remainder: remainBalance))
        emogiImageView.image     = budgetStatus.emoji
        budgetStatusLabel.text   = budgetStatus.status
        OverviewTableView.reloadData()
    }
    
    
}





