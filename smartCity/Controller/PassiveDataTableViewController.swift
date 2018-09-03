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
            
            if let currentSensor = selectedSensor {
                
                self.curentSensorName = currentSensor.name
                //sensorDataLable.text = sensorDataArray?[1].value
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
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sensorDataArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    //MARK: - load sensor data from DB
    
    func loadSensorData()  {
        
        sensorDataArray = selectedSensor?.data.sorted(byKeyPath: "value", ascending: true)
        
    }
    
}
