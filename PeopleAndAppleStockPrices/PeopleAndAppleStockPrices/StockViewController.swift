//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ibraheem rawlinson on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    @IBOutlet weak var stockTableView: UITableView!
    var stocks = [Stocks]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stocks📉"
        stockTableView.dataSource = self
        loadStockData()
        
    }
    func loadStockData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
                do {
                    let myUrl = URL(fileURLWithPath: path)
                    let data = try Data.init(contentsOf: myUrl)
                     self.stocks = try JSONDecoder().decode([Stocks].self, from: data)
                    
                } catch {
                    print(error)
                }
            
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let settingStocksTo = stocks[indexPath.row]
        let roundedStockValue = Double(round(100*settingStocksTo.open)/100)
        cell.textLabel?.text = settingStocksTo.date
        cell.detailTextLabel?.text = "\(roundedStockValue)"
        return cell
    }
}
