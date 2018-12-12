//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ibraheem rawlinson on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockDate: UILabel!
    @IBOutlet weak var stockOpeningPrice: UILabel!
    @IBOutlet weak var stockClosingPrice: UILabel!
    var stockElementsIExpect: Stocks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllerItems()
        
    }
    func setUpViewControllerItems() {
        let roundedStockValueForOpen = Double(round(100*stockElementsIExpect.open)/100)
        let roundedStockValueForClose = Double(round(100*stockElementsIExpect.close)/100)
        checkStockPriceflow(roundedStockValueForOpen, roundedStockValueForClose)
        stockDate.text = stockElementsIExpect.date
        stockOpeningPrice.text = "Opening: \(roundedStockValueForOpen)"
        stockClosingPrice.text = "Closing: \(roundedStockValueForClose)"
        
       
    }
    func checkStockPriceflow(_ firstStock: Double, _ secondStock: Double ){
        if firstStock > secondStock {
            stockImage.image = UIImage.init(named: "thumbsDown")
            view.backgroundColor = .red
        } else if firstStock < secondStock {
            stockImage.image = UIImage.init(named: "thumbsUp")
            view.backgroundColor = .green
        
        }
    }

}
