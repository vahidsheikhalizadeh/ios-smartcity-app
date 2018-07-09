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
    
    //var sensorArray = [SensorDataModel]()
    
    var timer = Timer()
    
    var sensorArray: Results<SensorDataModel>?
    
    ////////////////////////////////////////////////
    //MARK: - RxSwift stuff
    
    let disposeBag = DisposeBag()
    
    let url = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD"
    
    ////////////////////////////////////////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: either read sensor list from DB or make REST call ?
        
          print(Realm.Configuration.defaultConfiguration.fileURL!)

        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sensorCustomCell", for: indexPath) as! CustomSensorCell

        // Configure the cell...
        
        // cell.textLabel?.text = sensorArray[indexPath.row].name
        
        if let sensor = sensorArray?[indexPath.row]{
            
            cell.sensorNameCell.text = sensor.name
        }
        
        
        return cell
    }
     ///////////////////////////////////////
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showData", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//        let tabCtrl: UITabBarController = segue.destination as! UITabBarController
    //        guard let destinationVS = tabCtrl.viewControllers![0] as! SensorDataViewController else {return}
//
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationVS.selectedSensor = sensorArray?[indexPath.row]
//
//        }
//    }
     ///////////////////////////////////////
    
    
    //MARK: - add a new sensor
    @IBAction func addSensorPressed(_ sender: UIBarButtonItem) {
        
        // here to use the new RXSwift --> create a new UICOntroller , add new sensor and then return to the list of sensors
        print("add sensor plus button pressed")
        
        let targetVC = storyboard?.instantiateViewController(withIdentifier: "AddSensorViewController") as! AddSensorViewController
        targetVC.ifButtonSelected
            .subscribe(onNext: { name in
                print(name)
                
            }).disposed(by: disposeBag)
        
        navigationController?.pushViewController(targetVC, animated: true)
        
        
        
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
    
    //MARK: - Networking
    // call the REST endpoint to get the list of sensors
    func getSensorList(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Success, Sensor List  Network Call")
                    let resultJSON : JSON = JSON(response.result.value!)
                    print(resultJSON)
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
            self.getSensorList(url: "")
        })
    }
    

}
