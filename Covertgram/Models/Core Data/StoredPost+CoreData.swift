//
//  StoredPost+CoreData.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 16/11/2020.
//

import CoreData

extension StoredPost {
    
    public class func fetchRequest() -> NSFetchRequest<StoredPost> {
        return NSFetchRequest<StoredPost>(entityName: "StoredPost")
    }
    
    public class func new(withManagedContext managedContext: NSManagedObjectContext) -> StoredPost {
        let entity = NSEntityDescription.entity(forEntityName: "StoredPost", in: managedContext)!
                
        let server = NSManagedObject(entity: entity, insertInto: managedContext)
        
        return server as! StoredPost
    }
    
    class func get(withManagedContext managedContext: NSManagedObjectContext) -> [StoredPost] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredPost")
        
        return (try? managedContext.fetch(fetchRequest) as? [StoredPost]) ?? []
    }
    
    func delete(withManagedContext managedContext: NSManagedObjectContext) {
        switch self.post.urls {
        case .image(let urls):
            urls.forEach { try? FileManager.default.removeItem(at: $0) }
            
        case .video(_, let url):
            try? FileManager.default.removeItem(at: url)
        }
        
        managedContext.delete(self)
        
        try! managedObjectContext?.save()
    }
}
