//
//  ViewController.swift
//  API Demo
//
//  Created by Lana Sanyoura on 1/11/17.
//  Copyright © 2017 Lana Sanyoura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func submit(_ sender: AnyObject) {
        if (textField.text != nil) {
        let city = textField.text!.replacingOccurrences(of: " ", with: "%20")
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=968cab1090300a5ecf4c9b4f69c6fddf")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                if let urlContent = data {
                    do {
                        let jsonContent = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonContent)
                        var message = ""
                        if let description = (((jsonContent["weather"]as? NSArray)?[0] as? NSDictionary)? ["description"]) as? String {
                            message += "\(description)\n"
                        }
                        if let deg = ((jsonContent["wind"] as? NSDictionary)? ["deg"]) as? String {
                            message += "Wind: \(deg) degrees"
                        }
                        if let speed = ((jsonContent["wind"] as? NSDictionary)? ["speed"]) as? String{
                            message += "with a speed of \(speed)\n"
                            
                        }
                        if let hum = ((jsonContent["main"] as? NSDictionary)? ["humidity"]) as? String {
                            message += "Humidityy is at \(hum)"
                        }
                        if let pressure = ((jsonContent["main"] as? NSDictionary)? ["pressure"]) as? String {
                            message += " with a pressure of \(pressure)"
                        }
                        if let temp = ((jsonContent["main"] as? NSDictionary)? ["temp"] ) as? String {
                            message += " and a temperature of \(temp)\n"
                        }
                        DispatchQueue.main.sync {
                            self.message.text = String(message)
                        }
                        
                    } catch {
                        print("\nJSON processing failed\n")
                    }
                }
            }
            else {
                print("\nERROR FOUND\n")
            }
        }
        task.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    


}

