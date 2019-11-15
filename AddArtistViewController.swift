//
//  ArtistDetailViewController.swift
//  musicRecs
//
//  Created by Priya Ganguly on 11/1/19.
//  Copyright © 2019 idk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddArtistViewController: UIViewController {
    
//    var selectedArtist:ArtistEntity!
    
//    var artistName:String?
//    var artistImage:String?
    
    @IBOutlet weak var artistNameLabel: UITextField!
    @IBOutlet weak var artistDescriptionLabel: UITextField!
    @IBOutlet weak var artistImageLabel: UIImageView!
    
 
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //array of artists from coredata
    var NSManagedObjectArray:ArtistEntity = ArtistEntity()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
//        destination.artistName = String(nameLabel.text!)
        
    }
    
    @IBAction func addInTable(_ sender: Any) {
        
        let ent = NSEntityDescription.entity(forEntityName: "ArtistEntity", in: self.managedObjectContext)
        
        let newItem = ArtistEntity(entity: ent!, insertInto: self.managedObjectContext)
        newItem.name = artistNameLabel.text
        //coreDataImage.zip
        //newItem.picture = UIImage(artistImageLabel.image)
        newItem.details = artistDescriptionLabel.text
        
        do {
            try self.managedObjectContext.save()
        } catch {
            
        }
        
    }
    
    
    
    
}
