//
//  SelectHospitalTableViewController.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/14.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class SelectHospitalTableViewController: UITableViewController {
    
    var searchResults: [Hospital] = []
    var loadingHospital = LoadingHospitalService()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        loadingHospital.getHospitalResults() { results,msg in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let results = results {
                self.searchResults = results
               self.tableView.reloadData()
                
            }
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HospitalTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HospitalCell else {
            fatalError("create cell fatal")
        }
        let track = searchResults[indexPath.row]
        cell.nameLabel.text = track.name
        cell.idLabel.text = String(track.id)
        
        
//
//        // Configure the cell...
//
//        let track = searchResults[indexPath.row]
//
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "ShowDepartment":

            guard let SDController = segue.destination as? SelectDepartmentTableViewController
                else {
                     fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectdHospitalCell = sender as? HospitalCell else {
                fatalError()
            }
            
            guard let indexPath = tableView.indexPath(for: selectdHospitalCell) else {
                fatalError()
            }
            let selectedHospital = searchResults[indexPath.row]
            SDController.hospital = selectedHospital
            print(selectdHospitalCell)
        default:
            print("default")
        }
    }
 

}
