//
//  DataBaseHelper.swift
//  Saving Image in Core Data
//
//  Created by Amol Rai on 07/12/19.
//  Copyright © 2019 Amit Rai. All rights reserved.
//

import UIKit
import CoreData

class DataBaseHelper {
    
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
            
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Image] {
        var fetchingImage = [Image]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Image]
        } catch {
            print("Error while fetching the image")
        }
        
        return fetchingImage
    }
}
