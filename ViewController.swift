//
//  ViewController.swift
//  musicRecs
//
//  Created by Priya Ganguly on 10/28/19.
//  Copyright © 2019 idk. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var artistsTable: UITableView!
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //array of artists from coredata
    var NSManagedObjectArray:ArtistEntity = ArtistEntity()
    
    var fetchResults = [ArtistEntity]()
    
    func fetchRecord() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArtistEntity")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x = 0
        
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [ArtistEntity])!
        
        x = fetchResults.count
        
        print(x)
        return x
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        artistsTable.register(UITableViewCell.self, forCellReuseIdentifier: "artistCell")
        
        artistsTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return number of artists
        return fetchRecord()
    }
    
    //data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //return cell with artist name and photo info

        let cell = artistsTable.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) // as! ArtistsTableViewCell
        cell.textLabel?.text = fetchResults[indexPath.row].name
        
//        let item = NSManagedObjectArray[indexPath.item]
//        cell.textLabel?.text = item

        if let picture = fetchResults[indexPath.row].picture {
            cell.imageView?.image = UIImage(data: picture as Data)
        } else {
            cell.imageView?.image = nil
        }

        return cell

    }
    
    //data source
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //return true
        return true
    }
    
    //delegate
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        //what kind of editing functions you want on the cell
        //return delete
        return UITableViewCell.EditingStyle.delete
    }
    
    //delegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //deletion proof
        //update table
        
    }
    
    func updateLastRow() {
        let indexPath = IndexPath(row: fetchResults.count - 1, section: 0)
        artistsTable.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArtistEntity")

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch let _ as NSError {

        }
        
        artistsTable.reloadData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        }

    @IBAction func backToTable(segue: UIStoryboardSegue) {
        artistsTable.reloadData()
    }
    
    


}

