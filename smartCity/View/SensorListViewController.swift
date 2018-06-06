//
//  SensorListTableViewController.swift
//  smartCity
//
//  Created by shick on 29.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import RealmSwift

class SensorListTableViewController: UITableViewController {

    
    @IBOutlet var sensorListTableView: UITableView!
    
    let realm = try! Realm()
    
    //var sensorArray = [SensorDataModel]()
    
    
    var sensorArray: Results<SensorDataModel>?
    
    
    ////////////////////////////////////////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO: either read sensor list from DB or make REST call ?
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadSensorList()
        
        //MARK:-  Register your MessageCell.xib file here
        
        sensorListTableView.register(UINib(nibName: "CustomSensorCell", bundle: nil), forCellReuseIdentifier: "sensorCustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        let cell = sensorListTableView.dequeueReusableCell(withIdentifier: "sensorCustomCell", for: indexPath)

        // Configure the cell...
        
        // cell.textLabel?.text = sensorArray[indexPath.row].name
        
        if let sensors = sensorArray?[indexPath.row]{
            
            cell.textLabel?.text = sensors.name
        }
        
        
        return cell
    }
     ///////////////////////////////////////
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let tabCtrl: UITabBarController = segue.destination as! UITabBarController
        let destinationVS = tabCtrl.viewControllers![0] as! SensorDataViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVS.selectedSensor = sensorArray?[indexPath.row]
            
        }
    }
     ///////////////////////////////////////
    
    
    //MARK: - add a new sensor
    @IBAction func addSensorPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
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
    }
    
    //MARK: - data manipulation
    /////////////////////////////////////////
    
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

}
