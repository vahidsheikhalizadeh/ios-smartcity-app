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
            print("DIDIDIDI")
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
