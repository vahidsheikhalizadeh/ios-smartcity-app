//
//  AddSensorViewController.swift
//  smartCity
//
//  Created by shick on 12.06.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON

class AddSensorViewController: UIViewController {
    
    
    
    @IBOutlet weak var sensorNameTextField: UITextField!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    private var ifAddButtonSelectedVariables = Variable("")
    
    var ifButtonSelected : Observable<String>{
    
        return ifAddButtonSelectedVariables.asObservable()
    }

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
        
        ifAddButtonSelectedVariables.value = sensorName
        ifAddButtonSelectedVariables.value = urlAdress
        
        addNewSensor(url: urlAdress,name: sensorName)
        
        
        }
    
    //MARK: - Networking
    func addNewSensor(url: String,name: String){
        
        Alamofire.request(url).responseJSON { response in
            debugPrint(response)
            
            if let json : JSON = JSON (response.result.value!) {
                print("JSON: \(json)")
                self.updateSensorData(json: json)
            }
        }
        
    }
    
    //MARK: - JSON Parsing
    /**************************************************************/
    
    func updateSensorData(json : JSON){
        
        let sensorResult = json ["sensors"]["data"][6]
        print("\(sensorResult)")
    }
        

}


