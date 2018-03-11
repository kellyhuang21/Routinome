//
//  ViewController.swift
//  xibProject
//
//  Created by Alejandro Castillejo on 2/24/17.
//  Copyright © 2017 Alejandro Castillejo. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var jsonArray:Array<Any>?
    var text:String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //Add header view
        //        var header :TeamTableViewHeader?
        //        header = TeamTableViewHeader(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height/30))
        //        self.tableView.tableHeaderView = header
        
        //Eliminate random header on tableView
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Eliminate extra cells
        self.tableView.tableFooterView = UIView()
        
        //Set separator color
        //        self.tableView.separatorColor = UIColor.gray1()
        
        //eliminate separator
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Round tableView
        //        self.tableView.layer.cornerRadius = 5.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.startTimeLabel.text = self.text
        
        print(jsonArray)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
//        let cell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        if let elementArray = jsonArray![indexPath.row] as? Array<Any> {
            
            if let elementTitle = elementArray[0] as? String {
                
                if elementTitle == "Coffee Break" {
                    
                    cell.emojiLabel.text = "☕️"
                    cell.titleLabel.text = "Coffee"
                    
                } else if elementTitle == "Exercise-jog" {
                    
                    cell.emojiLabel.text = "🏃🏻‍♀️"
                    cell.titleLabel.text = "Exercise"
                    
                } else if elementTitle == "Power nap" {
                    
                    cell.emojiLabel.text = "💤"
                    cell.titleLabel.text = "Power nap"
                    
                } else if elementTitle == "Study" {
                    
                    cell.emojiLabel.text = "📚"
                    cell.titleLabel.text = "Work"
                    
                } else if elementTitle == "Snack-vitamin A" {
                    
                    cell.emojiLabel.text = "🍅"
                    cell.titleLabel.text = "Snack"
                    
                } else if elementTitle == "Snack-calcium" {
                    
                    cell.emojiLabel.text = "🥛"
                    cell.titleLabel.text = "Snack"
                    
                } else if elementTitle == "Snack-iron" {
                    
                    cell.emojiLabel.text = "🥦"
                    cell.titleLabel.text = "Snack"
                    
                } else if elementTitle == "Snack-b12" {
                    
                    cell.emojiLabel.text = "🥓"
                    cell.titleLabel.text = "Snack"
                    
                } else if elementTitle == "Snack-vitamin E" {
                    
                    cell.emojiLabel.text = "🥑"
                    cell.titleLabel.text = "Snack"
                    
                } else if elementTitle == "Snack-vitamin D" {
                    
                    cell.emojiLabel.text = "🍃"
                    cell.titleLabel.text = "Snack"
                    
                } else if elementTitle == "Relax-doodle" {
                    
                    cell.emojiLabel.text = "🎨"
                    cell.titleLabel.text = "Doodle"
                    
                } else if elementTitle == "Relax-stretch" {
                    
                    cell.emojiLabel.text = "🙆🏻‍♀️"
                    cell.titleLabel.text = "Stretch"
                    
                } else if elementTitle == "Relax-phone browsing" {
                    
                    cell.emojiLabel.text = "📱"
                    cell.titleLabel.text = "Phone browsing"
                    
                } else if elementTitle == "Relax-watch cat video" {
                    
                    cell.emojiLabel.text = "😸"
                    cell.titleLabel.text = "Watch cat video"
                    
                } else if elementTitle == "Relax-watch dog video" {
                    
                    cell.emojiLabel.text = "🐶"
                    cell.titleLabel.text = "Watch dog video"
                    
                } else if elementTitle == "Done!" {
                    
                    cell.emojiLabel.text = "🏁"
                    cell.titleLabel.text = "Done!"
                    
                }  else {
                    cell.emojiLabel.text = ""
                    cell.titleLabel.text = ""
                }

            }  else {
                cell.emojiLabel.text = ""
                cell.titleLabel.text = ""
            }
            
            if let elementText = elementArray[1] as? String {
                if elementText != "" {
                    cell.descriptionLabel.text = elementText
                } else {
                    cell.descriptionLabel.text = ""
                }
            } else {
                cell.descriptionLabel.text = ""
            }
            
            if let elementLength = elementArray[2] as? Int {
                if elementLength != 0 {
                    cell.numberLabel.text = String(elementLength)
                    cell.timeLabel.text = "mins"
                } else {
                    cell.numberLabel.text = ""
                    cell.timeLabel.text = ""
                }
            } else {
                cell.numberLabel.text = ""
            }

            
        }
        
        return cell
        
    }
    
    @IBAction func backWasPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
