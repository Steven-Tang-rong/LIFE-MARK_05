//
//  addTimeTVC.swift
//  LIFE MARK
//
//  Created by TANG,QI-RONG on 2020/7/6.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit
import CoreData

class addTimeTVC: UITableViewController {

    var addTimeCoreData: LifeMarker!
    var addTimeCellTitleText = String()
    var addTimeCellMainText = String()
    var addTimeCellOtherText = String()
    
    @IBOutlet weak var addTimeDatePicker: UIDatePicker!

    @IBOutlet weak var addTimeTitleTextField: UITextField!
    
    @IBOutlet weak var addTimeMainTextField: UITextField!
    
    @IBOutlet weak var addTImeOtherTextView: UITextView!
    
    @IBAction func addTimeDatePickerAction(_ sender: Any) {
        // 設置要顯示在 UILabel 的日期時間格式
        addTimeDatePicker.locale = Locale(identifier: "zh_TW")
        addTimeDatePicker.datePickerMode = .time
            
    }
         
    func timeNotification() {
    let content = UNMutableNotificationContent()
        content.title       =  addTimeTitleTextField.text!
        content.subtitle    =  addTimeMainTextField.text!
        content.badge       = 1
        content.sound       = UNNotificationSound(named:UNNotificationSoundName(rawValue: "Gintama.aiff"))
          
        let date            = addTimeDatePicker.date
        let components      = Calendar.current.dateComponents([ .hour, .minute], from: date)
        let trigger         = UNCalendarNotificationTrigger(dateMatching: components,
                                                              repeats: false)
        let request         = UNNotificationRequest(identifier: "notificationl",
                                                      content: content, trigger: trigger)
       
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
     }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        //取得AppDelegate內容
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            addTimeCoreData = LifeMarker(context: appDelegate.persistentContainer.viewContext)
            
            addTimeCoreData.datePicker = addTimeDatePicker.date
           
            //標題
            if addTimeTitleTextField.text != "" {
                addTimeCoreData.timerTitle = addTimeTitleTextField.text
            }else {
                addTimeTitleTextField.text = "沒有輸入標題"
                addTimeCoreData.timerTitle = addTimeTitleTextField.text
            }
            
            //主題
            if addTimeMainTextField.text != "" {
                addTimeCoreData.timerMainTask = addTimeMainTextField.text
            }else {
                addTimeMainTextField.text = "沒有輸入訊息"
                addTimeCoreData.timerMainTask = addTimeMainTextField.text
            }
            
            //次要
            addTimeCoreData.timerOtherTask = addTImeOtherTextView.text
            //Switch
            addTimeCoreData.timerSwitch = true
            
            timeNotification()
            print("Saving data to contect")
            appDelegate.saveContext()
        }
    
        dismiss(animated: true, completion: nil)

 }
  
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /*
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "zh_TW")
    formatter.timeStyle = .short

    
    let formatterString = formatter.string(from: myDatePickerData.date)*/
}






