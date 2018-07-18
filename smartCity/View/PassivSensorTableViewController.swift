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

class PassivSensorTableViewController: UITableViewController {
   
    
   
    let realm = try! Realm()
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var passicSensorListTableView: UITableView!
    
    var sensorArray  = ["Test"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passicSensorListTableView.register(UINib(nibName: "CustomSensorCell", bundle: nil), forCellReuseIdentifier: "sensorCustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sensorArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "sensorCustomCell", for: indexPath) as! CustomSensorCell
        //cell.delegate = self
        cell.sensorNameCell.text = sensorArray[indexPath.row]
        
       
        
        return cell
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showData", sender: self)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sensorArray.remove(at: indexPath.item)
            
            /*
             here to remove from the database
             
             do {
             try realm.write{
             realm.delete(sensorArray[indexPath.row])
             }
             }
             catch{
             print("Error deleting passiv sensor \(error)")
                }
             
             
             */
        
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    @IBAction func addSensorPressed(_ sender: UIBarButtonItem) {
        
        
        let targetVC = storyboard?.instantiateViewController(withIdentifier: "AddSensorViewController") as! AddSensorViewController
        
        navigationController?.pushViewController(targetVC, animated: true)
        
        targetVC.ifButtonSelected
            .subscribe(onNext: { name in
                print(name)
                
                self.sensorArray.append(name)
                self.tableView.reloadData()
                
            }).disposed(by: disposeBag)

    }
}


////MARK: - Swipe Cell Delegate Method
//
//extension PassivSensorTableViewController: SwipeTableViewCellDelegate{
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//
//            print("Swipe closure execution !")
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
//}
