//
//  FavoriteProvider.swift
//  Rawgames
//
//  Created by Fidriyanto R on 19/08/21.
//

import CoreData

class FavoriteProvider {
    let entityName = "Favorite"
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteGames")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    func getFavoriteGames(completion: @escaping(_ members: [FavoriteModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            do {
                let results = try taskContext.fetch(fetchRequest)
                var favorites: [FavoriteModel] = []
                for result in results {
                    let favorite = FavoriteModel(
                        id: result.value(forKey: "id") as? Int32,
                        name: result.value(forKey: "name") as? String,
                        publishers: result.value(forKey: "publishers") as? String,
                        releasedDate: result.value(forKey: "releasedDate") as? String,
                        rating: result.value(forKey: "rating") as? Double,
                        platforms: result.value(forKey: "platforms") as? String,
                        backgroundImage: result.value(forKey: "backgroundImage") as? String,
                        genres: result.value(forKey: "genres") as? String,
                        description: result.value(forKey: "desc") as? String,
                        metacritic: result.value(forKey: "metacritic") as? Int
                    )
                    favorites.append(favorite)
                }
                completion(favorites)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func getFavoriteGameById(_ id: Int, completion: @escaping(_ members: FavoriteModel?) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let favorite = FavoriteModel(
                        id: result.value(forKey: "id") as? Int32,
                        name: result.value(forKey: "name") as? String,
                        publishers: result.value(forKey: "publishers") as? String,
                        releasedDate: result.value(forKey: "releasedDate") as? String,
                        rating: result.value(forKey: "rating") as? Double,
                        platforms: result.value(forKey: "platforms") as? String,
                        backgroundImage: result.value(forKey: "backgroundImage") as? String,
                        genres: result.value(forKey: "genres") as? String,
                        description: result.value(forKey: "desc") as? String,
                        metacritic: result.value(forKey: "metacritic") as? Int
                    )
                    completion(favorite)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func getFavoriteState(_ id: Int, completion: @escaping(_ bool: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                let isFavorite = try taskContext.fetch(fetchRequest).first != nil
                completion(isFavorite)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func addFavorite(_ favoriteModel: FavoriteModel) throws {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: taskContext) {
                let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
                favorite.setValue(favoriteModel.id, forKeyPath: "id")
                favorite.setValue(favoriteModel.name, forKeyPath: "name")
                favorite.setValue(favoriteModel.releasedDate, forKeyPath: "releasedDate")
                favorite.setValue(favoriteModel.backgroundImage, forKeyPath: "backgroundImage")
                favorite.setValue(favoriteModel.metacritic, forKeyPath: "metacritic")
                favorite.setValue(favoriteModel.rating, forKeyPath: "rating")
                favorite.setValue(favoriteModel.description, forKeyPath: "desc")
                favorite.setValue(favoriteModel.publishers, forKeyPath: "publishers")
                favorite.setValue(favoriteModel.genres, forKeyPath: "genres")
                favorite.setValue(favoriteModel.platforms, forKeyPath: "platforms")
                do {
                    try taskContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    func deleteFavorite(_ id: Int) throws {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            do {
                try taskContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        }
    }
}
