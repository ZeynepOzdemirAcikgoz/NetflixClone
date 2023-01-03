//
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 3.01.2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    enum DatabaseError : Error {
        
        case failedToSaveData
        case failedToFetchData
        case faileToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.realese_date = model.realese_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        
        do {
             try context.save()
            completion(.success(()))

        } catch{
            completion(.failure(DatabaseError.failedToSaveData))
            
        }
    }
    
    func fethingTitlesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
            
            
            
        }catch{
            
            completion(.failure(DatabaseError.failedToFetchData))
            
        }
    }
    func deleteTitleWith( model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        context.delete(model) // asking the database manager to delete certain object
        
        do {
             try context.save()
            completion(.success(()))

        } catch{
            completion(.failure(DatabaseError.faileToDeleteData))
            
        }
        
    }
}
