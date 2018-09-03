//
//  PassivSensorTableViewController.swift
//  smartCity
//
//  Created by shick on 13.07.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import Realm
import Alamofire
import SwiftyJSON

class PassivSensorTableViewController: UITableViewController, CanReceive {
    
    var sensorName = ""
    var sensorData = ""
    
    var sensorCurrentData: String = "no data vailable"
    
    let realm = try! Realm()
    
    var sensorArray: Results<GenericModel>?
    
    @IBOutlet var passiveTableView: UITableView!

    @IBOutlet var passicSensorListTableView: UITableView!
    
    func dataReceive(name: String,data: String) {
        sensorName = name
        sensorData = data
        print("!!!!!!!!!!!!",sensorData)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadSensorList()
        
        //it is possible to write a function and get sensors which the name!= nil and call it here
        
        passicSensorListTableView.register(UINib(nibName: "CustomSensorCell", bundle: nil), forCellReuseIdentifier: "sensorCustomCell")
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sensorArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

         let cell = tableView.dequeueReusableCell(withIdentifier: "sensorCustomCell", for: indexPath) as! CustomSensorCell
    
        
        if let sensor =  sensorArray?[indexPath.row]{
            cell.sensorNameCell.text = sensor.name
        }
        
         return cell
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "showData", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showData"{
            
            let destinationVC = segue.destination as! PassiveDataTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                
            destinationVC.selectedSensor = sensorArray?[indexPath.row]
    
            }
        }
        else if segue.identifier == "addSensor" {
            let destinationVC = segue.destination as! AddSensorViewController
            destinationVC.delegate = self
        }
    }

    //MARK: - delete a sensor(row) from table view
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
             
             do {
             try realm.write{
                realm.delete((sensorArray?[indexPath.row])!)
             }
             }
             catch{
             print("Error deleting passiv sensor \(error)")
                }
        
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        
    }
    
    @IBAction func addSensorPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "addSensor", sender: self)
        
                tableView.reloadData()
    }
    
    //MARK: - load sensor data from DB
    
    func loadSensorList() {
        
        sensorArray = realm.objects(GenericModel.self)
        
        tableView.reloadData()
    }
    
    
    //MARK: - fetch sensor data
    func fetchSensorData(name: String,index: Int) -> String {
        
        let url = "http://localhost:8080/last/" + name
        
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    let json : JSON = JSON(response.result.value!)
                    print("JSONNNNNN:",json)
                    let sensorData = json ["data"][1].string!
                    print("SENSOR DATA WOOHOO\(sensorData)")
                    self.sensorCurrentData = sensorData
                    if let sensor = self.sensorArray?[index]{
                    do {
                        try self.realm.write {
                            print("SENSOR DATA ::::",sensorData)
                            let data = Data()
                            data.value = sensorData
                            sensor.data.append(data)
                        }
                    }
                    catch{
                        print("Error saving data in sensors")
                    }
                    }
                }
                    
                else {
                    print("Error: \(String(describing: response.result.error))")
                }
                
        }
        
        return sensorCurrentData
    }

}

