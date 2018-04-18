//
//  ViewController.swift
//  singleBit
//
//  Created by Julio Ahuactzin on 10/04/18.
//  Copyright © 2018 Julio Ahuactzin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btcLast: UILabel!
    @IBOutlet weak var btcHigh: UILabel!
    @IBOutlet weak var btcLow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func updateAction(_ sender: Any) {
        ///////// BTC price
        let urlBitso = URL(string: "https://api.bitso.com/v2/ticker/?book=btc_mxn")
        let sessionBitso = URLSession.shared
        let task = sessionBitso.dataTask(with: urlBitso!, completionHandler:{data, response, error -> Void in
            
            do {
                let JSON = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers)
                guard let JSONDictionary :NSDictionary = JSON as? NSDictionary else {
                    print("Not a Dictionary")
                    // put in function
                    return
                }
                
                print("JSONDictionary! \(JSONDictionary)")
                DispatchQueue.main.async {
                    let priceHigh = JSONDictionary["high"] as! String
                    let high = ("$\(priceHigh) MXN")
                    self.btcHigh.text = high
                    let priceLow = JSONDictionary["low"] as! String
                    let low = ("$\(priceLow) MXN")
                    self.btcLow.text = low
                    let priceLast = JSONDictionary["last"] as! String
                    let last = ("$\(priceLast) MXN")
                    self.btcLast.text = last
                    self.dismiss(animated: false, completion: nil)
                    
                }
            }
            catch let JSONError as NSError {
                print("\(JSONError)")
            }
            
        })
        task.resume()
        //////BTC price
        
        
        
        
        
        
        
        
        //adding a loading alert
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        ///////////////////////
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

