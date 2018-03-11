//
//  ViewController.swift
//  xibProject
//
//  Created by Alejandro Castillejo on 2/24/17.
//  Copyright © 2017 Alejandro Castillejo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var hoursTextfield: UITextField!
    @IBOutlet weak var getPlanButton: UIButton!
    
    var minutes = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hoursTextfield.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(ViewController.checkAction(sender:)))
        self.view.addGestureRecognizer(gesture)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func checkAction(sender : UITapGestureRecognizer) {
        
        self.hoursTextfield.resignFirstResponder()
        
    }

    @IBAction func requestWasPressed(_ sender: Any) {
        
        print("requestWasPressed")

//        Alamofire.request("http://48f3d412.ngrok.io/get?hours=5").responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//
//                self.showScheduleScreen()
//
//            }
//        }
        
        if minutes > 0 {
            
            let urlString = "http://48f3d412.ngrok.io/get?minutes=" + String(minutes)
            
            Alamofire.request(
                URL(string: urlString)!,
                method: .get,
                parameters: ["include_docs": "true"])
                .validate()
                .responseJSON { (response) -> Void in
                    
                    guard response.result.isSuccess else {
                        print("Error while fetching remote rooms: \(response.result.error)")
                        //                    completion(nil)
                        return
                    }
                    
                    print(response)
                    
                    if let responseValue = response.result.value {
                        
                        let json = JSON(responseValue)
                        
                        let responseCode = response.response?.statusCode ?? 400
                        
                        var jsonDictionary:NSDictionary? = nil
                        
                        if let _ = json.dictionaryObject {
                            jsonDictionary = json.dictionaryObject! as NSDictionary
                        }
                        
                        if let jsonArray = json.arrayObject {
                            
                            print(jsonArray)
                            
                            
                            let viewController = ScheduleViewController(nibName: "ScheduleViewController", bundle: nil)
                            
                            if let hello = jsonArray[0] as? Array<Any> {
                                
                                if let bye = hello[2] as? Int {
                                    
                                    viewController.text = "Start at " + String(bye) + " am"
                                    
                                    var mutableArray:Array<Any> = jsonArray
                                    mutableArray.remove(at: 0)
                                    viewController.jsonArray = mutableArray as! Array<Any>
                                    
                                    self.navigationController?.pushViewController(viewController, animated: true)
                                    
                                }
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
            }
            
        } else {
            
            print("alert")
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        let locale = Locale.init(identifier: "da_DK")
        datePickerView.locale = locale
//        initWithLocaleIdentifier:@""
//        [datePicker setLocale:locale];
        
        datePickerView.datePickerMode = UIDatePickerMode.time
        
        datePickerView.minuteInterval = 5
        
        hoursTextfield.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hoursTextfield.resignFirstResponder()
        return true
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.none
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let locale = Locale.init(identifier: "da_DK")
        dateFormatter.locale = locale
        
        let calendar = Calendar.current // or e.g. Calendar(identifier: .persian)
        
        let hour = calendar.component(.hour, from: sender.date)
        let minute = calendar.component(.minute, from: sender.date)
        
        minutes = hour*60 + minute
        
        print(minutes)
        
        hoursTextfield.text = String(hour) + " hours" + " " + String(minute) + " minutes"
        
    }
    
}
