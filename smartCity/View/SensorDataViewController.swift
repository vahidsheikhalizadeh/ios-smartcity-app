//
//  SensorDataViewController.swift
//  smartCity
//
//  Created by shick on 29.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire

class SensorDataViewController: UITableViewController {
    
    var curentSensorName : String = ""
    
    @IBOutlet var sensorDataTableView: UITableView!
    
    var sensorDataArray:Results<Data>?
    
    let realm = try! Realm()
    
    var selectedSensor : SensorDataModel?{
        
        didSet{
            if let currentSensor = selectedSensor {
                
                     self.curentSensorName = currentSensor.name
            }
            loadSensorData()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      sensorDataTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "dataCustomeCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sensorDataArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("SENSOR DATA CELL")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCustomeCell", for: indexPath) as! DataTableViewCell
        
        if let data = sensorDataArray?[indexPath.row]{
            cell.sensorDataValue.text = data.value
            let image : UIImage = UIImage(named: updateSensorIcon(name: curentSensorName ))!
            print("SENSOR NAME: \(curentSensorName)")
            cell.sensorDataImage.image = image
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
    func loadSensorData()  {
    
        sensorDataArray = selectedSensor?.datas.sorted(byKeyPath: "value", ascending: true)
        
    }
    
    func updateSensorIcon(name: String) -> String {
        
        switch name {
            
        case "Temperatur":
            return "temperature-icon"
            
        case "Luftfeuchtigkeit":
            return "humidity-icon"
            
        case "Lichtsensor":
            return "light-icon"
            
        case "Parkplatz":
            return "parking-icon"
            
        case "Füllstand":
            return "trash-icon"
            
        case "Solar":
            return "solar-icon2"

        default:
            return "sensor"
        }
    
    }
}
