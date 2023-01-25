//
//  ViewController.swift
//  FavoritePlace_VijayBharathReddy_C0872418
//
//  Created by Vijay Bharath Reddy Challa on 2023-01-24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var Name :String = " "
    
    
    
    @IBOutlet weak var placeList: UITableView!
    let sb = UIStoryboard(name: "Main", bundle: nil)
    
    private var modals = [Locationlist]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getdata()
       
        placeList.dataSource = self
        placeList.delegate = self
        title = "favorite Places"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placeList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let modal = modals[indexPath.row]
        //let x:String = String(modal.locality!) + String(modal.pincode)
        cell.textLabel?.text = modal.locality
        print(modal.locality)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //send the location name to second Screen
        
        let secondVC = sb.instantiateViewController(identifier: "MapViewController")
         // MapViewController.text = modal[indexPath.row]
               self.navigationController?.pushViewController(secondVC, animated: true)
       
        
        //secondVC.text = String(Locationlist)
       // present(secondVC,animated: true,completion: nil)
        
           }
    
    func tableView(_ _tableView:UITableView, trailingSwipeActionsConfigurationForRowAt Indexpath :IndexPath ) -> UISwipeActionsConfiguration?{
        let action = UIContextualAction(style: .destructive, title: "delete"){(action,view, completionHandler)in
            //
            let removeLocation =  self.modals[Indexpath.row]
            self.deleteData(item: removeLocation)
            self.placeList.reloadData()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    
    
    func getdata(){
        // get favorite location list
        do{
            modals = try context.fetch(Locationlist.fetchRequest())
            placeList.reloadData()
            DispatchQueue.main.async {
                self.placeList.reloadData()
                //print("updated")
            }
        }
        catch{
            
        }
        
    }
    
    func createdata(locality:String){
        
        // Add new location to the list
        let newItem = Locationlist(context: context)
        
        newItem.locality = Name
        
        
        //newItem.pincode = pincode
        do{
            try context.save()
            getdata()
            print("saved")
            
        }
        catch{
            print("error")
            
        }
        
        
        
    }
    
    func deleteData(item: Locationlist){
        //delete the data
        context.delete(item)
        
            do{
            try context.save()
                
            placeList.reloadData()
        }
        catch{
            
        }
        
    }
    func updateData(item:Locationlist,newlocality:String,newpincode:Int64){
        
       // item.locatlity = newlocality
        item.pincode = newpincode
        do{
            try context.save()
            placeList.reloadData()
        }
        catch{
            
        }
        
        // Update the data with new location with pin drag
        
    }
    
   
    
        
    
    @IBAction func addBtn(_ sender: Any) {
        createdata(locality: Name)
    }
    
    


}


