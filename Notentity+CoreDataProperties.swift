//
//  Notentity+CoreDataProperties.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 18.08.2023.
//
//

import Foundation
import CoreData


extension Notentity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notentity> {
        return NSFetchRequest<Notentity>(entityName: "Notentity")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var status: Int32
    @NSManaged public var title: String?
    @NSManaged public var type: Int32
    @NSManaged public var ofFolder: Folder?

}

extension Notentity : Identifiable {

}
