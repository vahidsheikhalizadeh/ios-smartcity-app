//
//  SensorListTableViewController.swift
//  smartCity
//
//  Created by shick on 29.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit

class SensorListTableViewController: UITableViewController {

    
    @IBOutlet var sensorListTableView: UITableView!
    
    var sensorArray = [SensorDataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO: either read sensor list from DB or make REST call ?
        
        let newSensor = SensorDataModel()
        newSensor.name = ""
        sensorArray.append(newSensor)
        
        let newSensor2 = SensorDataModel()
        newSensor2.name = ""
        sensorArray.append(newSensor2)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        //MARK:-  Register your MessageCell.xib file here
        sensorListTableView.register(UINib(nibName: "CustomSensorCell", bundle: nil), forCellReuseIdentifier: "sensorCustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sensorArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
     ///////////////////////////////////////

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = sensorListTableView.dequeueReusableCell(withIdentifier: "sensorCustomCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = sensorArray[indexPath.row].name
        

        return cell
    }
     ///////////////////////////////////////
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showData", sender: self)
    }
    
     ///////////////////////////////////////
    
    
    //Mark: - add a new sensor
    @IBAction func addSensorPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Sensor", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Sensor", style: .default) { (action) in
            // what will happen once the user press the add item button on UIAlert
        
            let newSensor = SensorDataModel()
            newSensor.name = textField.text!
            
            self.sensorArray.append(newSensor)
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "create a new Sensor"
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    

}
