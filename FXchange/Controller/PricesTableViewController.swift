//
//  PricesTableViewController.swift
//  FXchange
//
//  Created by OLAJUWON on 8/6/18.
//  Copyright © 2018 OLAJUWON. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class PricesTableViewController: UITableViewController {

//    @IBOutlet weak var currencyRate: UILabel!
//    @IBOutlet weak var currencyName: UILabel!
//
    
  
    
   // var currencyValue = [Double]()
    
    
    //MARK:- Api URL and Parameter
    var currencyURl = "http://data.fixer.io/api/latest"
    var accessKey = "5d9c40384cba4c796a12323c104f35d6"
    var base = "EUR"
 //   var currencyName: [String] = []
   // var CurrencyPrice: [String] = []
    var currency = [Currency]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let params = ["access_key":accessKey, "base": base]
        getExchangePrices(url: currencyURl,parameters: params)
        
        tableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceCell")
        configureTableView()
        
        
//        for object in currency{
//
//            currencyName = object["name"]
//            CurrencyPrice = object["prices"]
//
//        }
        
        //TODO: Register priceCell.xib file
        
      
        
    }

    
    
  
    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceTableViewCell
       
        let current: Currency
        current = currency[indexPath.row]
        
        let price = String(describing: current.currencyPrice)
        
        cell.currency.text = current.currencyname
        
        cell.price.text = price
       // print(price)

        return cell
        
       // cell.currency?.text =
       // cell?.currency.text = currency[indexPath.row]
        //return cell!

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    
    
    //MARK: - Networking
    
    func getExchangePrices(url: String,parameters:[String:String])
    {
        Alamofire.request(url, method: .get,parameters: parameters).responseJSON { response in
            
            if response.result.isSuccess{
                print("Success! Got Prices")
                let priceJSON: JSON = JSON(response.result.value!)
                self.updatePrices(json: priceJSON)
            }
            else{
                print("ERROR \(String(describing: response.result.error))")
              //  self.currencyName.text = "Connection Error"
            }
            self.tableView.reloadData()
        }
}
   
    func configureTableView(){
    
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
        
    }
    
    
    //MARK: - JSON PARSING
    func updatePrices(json: JSON){
        
       // let currency: NSArray = json as! NSArray
        
        for (name,prices) in json["rates"]{
            
            let curr = Currency()

            curr.currencyname = name
            curr.currencyPrice = prices as AnyObject
            currency.append(curr)
            
            
//            let curr = ("\(name)    \(prices)")
//
//            currency.append(curr)
        }

//        for prices in json["rates"].arrayValue{
//
//            let naira = prices["NGN"]
//            let dollar = prices["USD"]
//            let bitcon = prices["BTC"]
//
//            let prices = ["Naira": naira, "Dollar": dollar, "Bitcoin": bitcon]
//            currency.
//
//        }
    
    
   
}
}
