//
//  ViewController.swift
//  ElClima
//
//  Created by Cortell Shaw on 3/25/16.
//  Copyright © 2016 Two-FiveDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var city: UITextField!
    
    
    
    @IBOutlet var resultLabel: UILabel!
    
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        // Type in a city | downloads content of that city | if city is not found then enter another city | if good, enter takes forecast snippet
        
        
        
        var wasSuccessful = false
        
      
        
        let attemptedUrl = NSURL(string: "http://weather-forecast.com/locations/" + city.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                // taking the http and turning it into a string.
                
                if websiteArray.count > 1 {
                    
                    
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        // degrees sign is alt + 0 key
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.resultLabel.text = weatherSummary
                            
                        })
                        
                    }
                    
                }
                
                
                
            }

            if wasSuccessful == false {
            
            
                self.resultLabel.text = "Couldn't find the weather for that city, please try again."
            }
        }
        
        task.resume()
        } else {
            
            self.resultLabel.text = "Couldn't find the weather for that city, please try again."
        
        
        }

    }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // closing the keyboard
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    


}

