//
//  PassiveDataTableViewController.swift
//  smartCity
//
//  Created by shick on 31.08.18.
//  Copyright © 2018 vahid. All rights reserved.
//
import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire

class PassiveDataTableViewController: UITableViewController {
    
    @IBOutlet var passiveTableView: UITableView!
    var curentSensorName : String = ""
    var sensorDataArray:Results<Data>?
    let realm = try! Realm()
    
    var selectedSensor : GenericModel?{
        
        didSet{
            print("DIDIDIDIDIDIDIDIDID")
            if let currentSensor = selectedSensor {
                
                self.curentSensorName = currentSensor.name
                //sensorDataLable.text = sensorDataArray?[1].value
                
                print("§$§%§%%§%§",currentSensor.name)
            }
            loadSensorData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        passiveTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "dataCustomeCell")
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sensorDataArray?.count ?? 1
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "dataCustomeCell", for: indexPath) as! DataTableViewCell

        if let data = sensorDataArray?[indexPath.row]{
            
            cell.sensorDataValue.text = data.value
            print("SENSOR NAME: \(curentSensorName)")
            
        }
        else{
            cell.textLabel?.text = "sensor data is not available"
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - load sensor data from DB
    
    func loadSensorData()  {
        
        sensorDataArray = selectedSensor?.data.sorted(byKeyPath: "value", ascending: true)
        
    }
    
}
