//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//StockPrice
//  Created by Ibraheem rawlinson on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit


class StockViewController: UIViewController {
    @IBOutlet weak var stockTableView: UITableView!
    var stocks = [Stock]()
    var previousDate = ""
    var startIndex = 0
    var matrixStock = [[Stock]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stocks📉"
        stockTableView.dataSource = self
        loadStockData()
        setMonths(allPrices: stocks)
        
    }
    
    func getDateMonth(dateString: String) -> (month: String, year: String) {
        let components = dateString.components(separatedBy: "-")
        return (components[1], components[0])
    }
    
    fileprivate func setMonths(allPrices: [Stock]) {
        let allPrices = allPrices
        var stockPrices = [[Stock]]()
        stockPrices.append([Stock]())
        var previousDate = ""
        var startIndex = 0
        for stockPrice in allPrices {
            let dateMonth = getDateMonth(dateString: stockPrice.date)
            let currentDate = dateMonth.month + "-" + dateMonth.year
            if previousDate.isEmpty { previousDate = dateMonth.month + "-" + dateMonth.year }
            if currentDate != previousDate {
                stockPrices.append([Stock]())
                startIndex += 1
            }
            stockPrices[startIndex].append(stockPrice)
            previousDate = dateMonth.month + "-" + dateMonth.year
        }
        matrixStock = stockPrices
    }
    func loadStockData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            do {
                let myUrl = URL(fileURLWithPath: path)
                let data = try Data.init(contentsOf: myUrl)
                self.stocks = try JSONDecoder().decode([Stock].self, from: data)
                
            } catch {print(error)}
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desitination = segue.destination as? StockDetailViewController, let indexPath = stockTableView.indexPathForSelectedRow else {fatalError("Error with the perapre for segue function")}
        desitination.stockElementsIExpect = stocks[indexPath.row]
    }
}
extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matrixStock.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let dateString = matrixStock[section].first?.date else {
            return "No date"
        }
        
        return String.formattedDate(srt: dateString)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let settingStocksTo = stocks[indexPath.row]
        let roundedStockValue = Double(round(100*settingStocksTo.open)/100)
        cell.textLabel?.text = settingStocksTo.date
        cell.detailTextLabel?.text = "\(roundedStockValue)"
        return cell
    }
}
