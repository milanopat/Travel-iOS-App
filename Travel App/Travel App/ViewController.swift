//
//  ViewController.swift
//  Travel App
//
//  Created by Milan Patel on 9/24/18.
//  Copyright © 2018 Milan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myCityList:Cities = Cities()
    
    @IBOutlet var cityTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCityList.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.cityTitle.text = myCityList.cityList[indexPath.row].cityName;
        cell.cityImage.image = UIImage(named: myCityList.cityList[indexPath.row].cityImage!)
        return cell
    }
    
    func tableView(_tableview: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        myCityList.cityList.remove(at: indexPath.row)
        
        self.cityTable.beginUpdates()
        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        self.cityTable.endUpdates()
    }
    
    
    @IBAction func addCity(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                print("City name: \(name)")
                let city6 = City(cn: name, cd: "Default description for new City being added.", cim: "denver.png")
                self.myCityList.cityList.append(city6)
                
                let indexPath = IndexPath (row: self.myCityList.cityList.count - 1, section: 0)
                self.cityTable.beginUpdates()
                self.cityTable.insertRows(at: [indexPath], with: .automatic)
                self.cityTable.endUpdates()
                
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let city = myCityList.cityList[selectedIndex.row]
        
        
        if(segue.identifier == "citySegue"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedCity = city.cityName
                viewController.selectedDescription = city.cityDescription
                viewController.selectedImage = city.cityImage
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

