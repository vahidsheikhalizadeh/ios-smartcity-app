//
//  AddSensorViewController.swift
//  smartCity
//
//  Created by shick on 12.06.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


protocol CanReceive {
    func dataReceive(data: String)
}

class AddSensorViewController: UIViewController {
    
    let group = DispatchGroup()
    
    let realm = try! Realm()
    
    var delegate : CanReceive?
    
    @IBOutlet weak var sensorNameTextField: UITextField!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    
    
//    private var ifAddButtonSelectedVariables = Variable("")
//
//    var ifButtonSelected : Observable<String>{
//
//        return ifAddButtonSelectedVariables.asObservable()
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addSensorPressed(_ sender: UIButton) {
        
        
        // here the RxSwift including a Network Call to the end point and turn back to the list of sensors
        
        guard let sensorName = sensorNameTextField.text else {return}
        guard let urlAdress = urlTextField.text else {return}
        
        //ifAddButtonSelectedVariables.value = sensorName
        
        delegate?.dataReceive(data: sensorName)
        
        addNewSensor(url: urlAdress,name: sensorName)
        saveSensorData(name: sensorName)
        group.notify(queue: .main) {
            print("yaya")
        }
        self.dismiss(animated: true, completion: nil)
        
        }
    
    //MARK: - Networking
    
    
    func addNewSensor(url: String,name: String){
        
        group.enter()
        
        let backendUrl = "http://localhost:9999/sensors/add"
        
        let parameters: [String:Any] = [
            "url":url,
            "name":name,
            "value":"",
            "device":"ZZZ"
            ]
        Alamofire.request(backendUrl, method: .post,parameters:parameters,encoding:JSONEncoding.default).responseString {
            response in
            print(response)
            // if response success then save the sensor
//             if   response.error != nil
//            {
//                self.saveSensorData(name: name)
//            }
        }
        
        
        
    }
    
    //MARK: - DATA Manipulation
    
    func saveSensorData(name: String) {
        group.enter()
        run(after: 1) {
            let url = "http://localhost:8080/last/" + name
            print("URL ::::",url)
            Alamofire.request(url, method: .get)
                .responseJSON { response in
                    if response.result.isSuccess {
                        
                        let json : JSON = JSON(response.result.value!)
    
                        let sensorData = json ["data"][1].string!
                        
                        let sensorDM = GenericModel()
                        sensorDM.name = name
                        
                        let data = Data()
                        data.value = sensorData
                        sensorDM.data.append(data)
                        
                        do {
                            try self.realm.write {
                                
                                self.realm.add(sensorDM)
                                
                                print("SENSOR SM:",sensorDM)
                            }
                        } catch {
                            print("Error saving SensorDM \(error)")
                        }
                    }
                        
                    else {
                        print("Error: \(String(describing: response.result.error))")
                    }
            }
            self.group.leave()
        }
    
    }
    
    //MARK: - Multithread of network calls
    /**************************************************************/
    func run(after second: Int, completion: @escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(second)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
}

    



