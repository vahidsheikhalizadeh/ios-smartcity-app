//
//  SensorListTableViewController.swift
//  smartCity
//
//  Created by shick on 29.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON
import RxSwift

class SensorListTableViewController: UITableViewController {

    
    @IBOutlet var sensorListTableView: UITableView!
    
    let realm = try! Realm()
    
    var timer = Timer()
    
    var sensorArray: Results<SensorDataModel>?
    
    ////////////////////////////////////////////////
    //MARK: - RxSwift stuff
    

    
    ////////////////////////////////////////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSensorData(url: "http://localhost:8080/sensors")
        
        loadSensorList()
        
        sensorListTableView.register(UINib(nibName: "CustomSensorCell", bundle: nil), forCellReuseIdentifier: "sensorCustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorArray?.count ?? 1
    }
    
    ///////////////////////////////////////
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
     ///////////////////////////////////////

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sensorCustomCell", for: indexPath) as! CustomSensorCell
        
        if let sensor = sensorArray?[indexPath.row]{
            
            cell.sensorNameCell.text = sensor.name
        }
        
        
        return cell
    }
     ///////////////////////////////////////
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVS = segue.destination as! SensorDataViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVS.selectedSensor = sensorArray?[indexPath.row]
            
            // here write the data to the current sensor in realm
            
            
            
        }
    }
    
    
     ///////////////////////////////////////
    
    
    //MARK: - Refresh sensor data
    

    
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        
        // here to use the new RXSwift --> create a new UICOntroller , add new sensor and then return to the list of sensors
        print("refresh button pressed")
        
        
        
      /*  var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Sensor", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Sensor", style: .default) { (action) in
            // what will happen once the user press the add item button on UIAlert
        
            let newSensor = SensorDataModel()
            newSensor.name = textField.text!
            
            self.saveSensorData(sensor: newSensor)
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "create a new Sensor"
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        */
    }
    
    
    
    
    
    //MARK: - Data manipulation
    
    
    func saveSensorData(sensor: SensorDataModel) {
        do {
            try realm.write {
                realm.add(sensor)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    /////////////////////////////////////////
    
    
    func loadSensorList() {
        
        sensorArray = realm.objects(SensorDataModel.self)
        
        
        tableView.reloadData()
    }
    
    
    
    //MARK: - Networking
    
    func fetchSensorData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Success, Sensor List  Network Call")
                    
                    let resultJSON : JSON = JSON(response.result.value!)
    
                    
                    let s1 = SensorDataModel()
                    s1.id = 1
                    s1.name = "Temperatur"
                    
                    let d1 = Data()
                    d1.value = resultJSON["_embedded"]["sensors"][1]["data"][4].string!
                    s1.datas.append(d1)
                   
                    
                    
                    let s2 = SensorDataModel()
                    s2.id = 2
                    s2.name = "Luftfeuchtigkeit"
                    
                    let d2 = Data()
                    d2.value = resultJSON["_embedded"]["sensors"][1]["data"][5].string!
                    s2.datas.append(d2)
                    
                    
                    
                    let s3 = SensorDataModel()
                    s3.id = 3
                    s3.name = "Lichtsensor"
                    
                    let d3 = Data()
                    d3.value = resultJSON["_embedded"]["sensors"][1]["data"][2].string!
                    s3.datas.append(d3)
                    
                    
                    let s4 = SensorDataModel()
                    s4.id = 4
                    s4.name = "Füllstand"
                    
                    let d4 = Data()
                    d4.value = resultJSON["_embedded"]["sensors"][1]["data"][3].string!
                    s4.datas.append(d4)
                    
                    
                    let s5 = SensorDataModel()
                    s5.id = 5
                    s5.name = "Solar"
    
                    let d5 = Data()
                    d5.value = resultJSON["_embedded"]["sensors"][1]["data"][1].string!
                    s5.datas.append(d5)
                    
                    
                    let s6 = SensorDataModel()
                    s6.id = 6
                    s6.name = "Parkplatz"
                    //s6.value = resultJSON["_embedded"]["sensors"][1]["data"][6].string!
                    
                    let d6 = Data()
                    d6.value = resultJSON["_embedded"]["sensors"][1]["data"][6].string!
                    let d7 = Data()
                    d7.value = resultJSON["_embedded"]["sensors"][1]["data"][7].string!
                    let d8 = Data()
                    d8.value = resultJSON["_embedded"]["sensors"][1]["data"][8].string!
                    let d9 = Data()
                    d9.value = resultJSON["_embedded"]["sensors"][1]["data"][9].string!
                    let d10 = Data()
                    d10.value = resultJSON["_embedded"]["sensors"][1]["data"][10].string!
                    let d11 = Data()
                    d11.value = resultJSON["_embedded"]["sensors"][1]["data"][11].string!
                    
                    s6.datas.append(d6)
                    s6.datas.append(d7)
                    s6.datas.append(d8)
                    s6.datas.append(d9)
                    s6.datas.append(d10)
                    s6.datas.append(d11)
                    
                    
                   
                    
                    
                    try! self.realm.write {
                        
                        self.realm.deleteAll()
                        self.realm.add(s1)
                        self.realm.add(s2)
                        self.realm.add(s3)
                        self.realm.add(s4)
                        self.realm.add(s5)
                        self.realm.add(s6)
                        
                    }
                    
                    print("RESULT: \(resultJSON["_embedded"]["sensors"][1]["data"][2])")
                    //self.updateBitcoinData(json: bitcoinJSON, curFormat: currency)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    //self.bitcoinPriceLabel.text = "Connection Issues"
                }
                
        }
        
    }
    
    
    //MARK: - Scheduler
    func createScheduler() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { (timer) in
            self.fetchSensorData(url: "HHH")
        })
    }
    
    
    func writeToDB(name: String) -> String {
        // IF NAME = ..  THEN DATA=..
        switch name {
            
        case "Temperatur":
            return ""
            
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
