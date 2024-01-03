//
//  AppModel.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 03.08.2023.
//

import Foundation
import CoreData
import UIKit

class AppModel {
    static let shared = AppModel()
    var notes: [Notentity] = []
    var folders: [Folder] = []
    var currentMonth = Calendar.current.dateComponents([.month], from: Date.now)
    lazy var context = UIApplication.shared.delegate as! AppDelegate
    
    private init() {
        
    }
    
    func addTask(_ note: Note) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("addTask failed.")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let newNote = Notentity(context: managedContext)
        newNote.title = note.title
        newNote.content = note.content
        newNote.type = note.typeValue
        newNote.status = note.statusValue
        newNote.date = note.date
        
        do {
            try managedContext.save()
            notes.append(newNote)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    
    func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            try managedContext.save()
        } catch {
            print("Save is not successful:(")
        }
    }
    
    func createFolder(named name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let newFolder = Folder(context: managedContext)
        newFolder.name = name
    }
    
    func fetchNotes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = Notentity.fetchRequest()
        let folderFetchRequest = Folder.fetchRequest()
        
        do {
            notes = try managedContext.fetch(fetchRequest)
            folders = try managedContext.fetch(folderFetchRequest)
        } catch let error as NSError {
            print("Couldn't load. \(error)")
        }
    }
    
    
    
    func getNotes() -> [Note] {
        let notes = self.notes.map { convertToNote(object: $0) }
        return notes
    }
    
    func convertToNote(object: NSManagedObject) -> Note {
        let title = object.value(forKeyPath: "title") as? String
        let content = object.value(forKeyPath: "content") as? String
        let type = object.value(forKeyPath: "type") as? Int32
        let status = object.value(forKeyPath: "status") as? Int32
        let date = object.value(forKeyPath: "date") as? Date
        
        return Note(title: title!, content: content!, typeValue: type!, statusValue: status!, date: date!)
    }
    
}
