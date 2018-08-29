//
//  GraphRatesViewController.swift
//  FXchange
//
//  Created by OLAJUWON on 8/6/18.
//  Copyright © 2018 OLAJUWON. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class GraphRatesViewController: UIViewController {

    
    var baseUrl = "http://data.fixer.io/api/timeseries"
    var key = "5d9c40384cba4c796a12323c104f35d6"
    var symbol  = "USD"
    var startdate = "2018-08-01"
    var end_date = "2018-08-25"
    var base = "EUR"
    
    
    
    @IBOutlet weak var LineGraph: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let params = ["access_key": key, "start_date": startdate, "end_date": end_date, "base": base, "symbols": symbol]
        
        getHistoryData(url: baseUrl, Parameters: params)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Networking 
    func getHistoryData(url: String ,Parameters: [String:String]){
        
        Alamofire.request(url, method: .get, parameters: Parameters).responseJSON { response in
            if response.result.isSuccess{
                print("Got data")
                let dataJSON: JSON = JSON(response.result.value!)
                print(dataJSON)
            }else {
                print("Error \(String(describing: response.result.error ))")
            }
        }
        
    }
    
    

}
