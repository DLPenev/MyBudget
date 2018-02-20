//
//  OverviewViewController.swift
//  My Budget
//
//  Created by MacUSER on 17.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var OverviewTableView:   UITableView!
    @IBOutlet var emogiImageView:      UIImageView!
    @IBOutlet var budgetStatusLabel:   UILabel!
    @IBOutlet var remainingValueLabel: UILabel!
    
    let expenseRepresentCellId = "expenseRepresentCellId"
    
    var segmentIndex           = 0
    var allExpenses: [Expense] = []
    var selectedRowIndex       = 0
    var butonIndex             = 0

    var allExpensesByPeriod: [[Expense]] = [[],[],[]] // allExpensesByPeriod[[today],[thisWeek],[thisMonth]]
    
    var listOfExpensesByCategory: [SumExpense] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  listOfExpensesByCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sumExpense = listOfExpensesByCategory[indexPath.row]
        
        let formatedProcent = "".doubleFormater(value: sumExpense.procentOfTotalExpense)
        let formatedValue   = "".doubleFormater(value: sumExpense.value)

        if let cell = OverviewTableView?.dequeueReusableCell(withIdentifier: expenseRepresentCellId) as? ExpenseRepresentOverviewCell {
            cell.categoryNameLabel.text  = sumExpense.categoryFullName
            cell.categoryIconImageView.image = sumExpense.categoryIcon
            cell.categoryIconImageView.backgroundColor = sumExpense.categoryColor
            cell.procentOfTotalExpenceLabel.text = "\(formatedProcent) %"
            cell.valueOfExpenseLabel.text = "\(formatedValue) \(globalUserDefaults.userCurrecy)"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath.row
        performSegue(withIdentifier: globalIdentificators.segueToExpenseDetails, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNewValuesAndRefreshTableView()
        
    }

    func sortExpenseByPeriod(){

        for expense in allExpenses {
            let expenseDay  = globalDateStruct.calendar.component(.day , from: Date(milliseconds: Int(expense.date)))
            let expenseWeek = globalDateStruct.calendar.component(.weekOfYear, from: Date(milliseconds: Int(expense.date)))
            let expenseMonth = globalDateStruct.calendar.component(.month, from: Date(milliseconds: Int(expense.date)))
           
            if expenseDay == globalDateStruct.today {
                allExpensesByPeriod[0].append(expense)
            }
            
            if expenseWeek == globalDateStruct.thisWeek {
                allExpensesByPeriod[1].append(expense)
            }
            
            if expenseMonth == globalDateStruct.thisMonth {
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
            return globalCashStatus.statusRich
        } else if reminder > oneThirdBudget {
            return globalCashStatus.statusGotSome
        } else if reminder < oneThirdBudget && reminder > 0 {
            return globalCashStatus.statusPoor
        } else {
            return globalCashStatus.statusBroke
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == globalIdentificators.segueToPopup{
            let destination = segue.destination as? PopUpViewController
            destination?.popupViewIndex = butonIndex
            destination?.popupDelegate = self
        }
        
        if segue.identifier == globalIdentificators.segueToExpenseDetails {
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
        
        if  segue.identifier == globalIdentificators.segueToARId {
            let destination = segue.destination as? ARViewController
            destination?.arrayOfSumExpense = listOfExpensesByCategory
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        segmentIndex = sender.selectedSegmentIndex        
        setNewValuesAndRefreshTableView()
    }
    
    @IBAction func addExpenseTouchUpInside(_ sender: Any) {
        butonIndex = globalIndexes.popupIndexExpense
        performSegue(withIdentifier: globalIdentificators.segueToPopup, sender: nil)
    }
    
    @IBAction func addIncomePressed(_ sender: Int) {
        butonIndex = globalIndexes.popupIndexIncome
        performSegue(withIdentifier: globalIdentificators.segueToPopup, sender: self)
    }
    
    @IBAction func logOutTouchUpInside(_ sender: UIButton) {
        print("logOutTouchUpInside")
        self.googleLogout()
        let firstViewController = storyboard?.instantiateViewController(withIdentifier: globalIdentificators.firstViewControllerId) as! FirstViewController
        present(firstViewController, animated: true, completion: nil)
    }
    
    func googleLogout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        GIDSignIn.sharedInstance().signOut()
    }
    
    @IBAction func buttonArTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: globalIdentificators.segueToARId, sender: self)
    }
    
}

extension OverviewViewController: PopupDelegate {

    func setNewValuesAndRefreshTableView() {

        DispatchQueue.global(qos: .userInteractive).async {
            
            var remainBalance: Double
            var totalBalance: Double
            self.allExpensesByPeriod = [[],[],[]]
            
            self.listOfExpensesByCategory = []
            
            self.allExpenses = DBManager.singleton.loadExpenses()
            self.sortExpenseByPeriod()
            self.listOfExpensesByCategory = self.getExpensesByCategory()
            remainBalance =  self.getRemainingAndTotalBalance(period:  self.segmentIndex).remainder
            totalBalance  =  self.getRemainingAndTotalBalance(period:  self.segmentIndex).total
            
            DispatchQueue.main.async {
                let budgetStatus =  self.getBudgetStatus(remainingAndTotalBalance: (total: totalBalance, remainder: remainBalance))
                self.emogiImageView.image     = budgetStatus.emoji
                self.budgetStatusLabel.text   = budgetStatus.status
                self.remainingValueLabel.text = "Balance :  \("".doubleFormater(value: remainBalance)) \(globalUserDefaults.userCurrecy) "
                self.OverviewTableView.reloadData()
            }
        }
        
    }
    
}





