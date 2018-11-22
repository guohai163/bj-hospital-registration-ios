//
//  SelectDepartmentTableViewController.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/19.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class SelectDepartmentTableViewController: UITableViewController {
    
    var hospital:Hospital?

    var departmentsService = DepartmentsService()
    
    var searchResults:[Departments] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let hospital = hospital {
            print(hospital)
        }
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
        departmentsService.loadingDepartments(hospitalId: hospital!.id) { data, msg in
             UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.searchResults = data!
            self.tableView.reloadData()
        }
    
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated:true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults[section].department.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchResults[section].category
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentCell", for: indexPath) as? DepartmentTableViewCell else {
            fatalError()
        }
        
        var data = self.searchResults[indexPath.section]
        cell.depIDLabel.text = String( data.department[indexPath.row].id)
        cell.depNameLabel.text = data.department[indexPath.row].name

        // Configure the cell...

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "ShowInfoData":
            guard let SDController = segue.destination as? SubmitDataViewController else {
                fatalError("fatal get ")
            }
            
            guard let selectDepartmentCell = sender as? DepartmentTableViewCell else {
                fatalError()
            }
            
            guard let indexPath = tableView.indexPath(for: selectDepartmentCell) else {
                fatalError()
            }
            
            let selectedDepartment = searchResults[indexPath.section].department[indexPath.row]
            print(selectedDepartment)
        default:
            print("default")
        }
    }
 

}
