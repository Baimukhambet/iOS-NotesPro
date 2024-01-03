//
//  Task.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import Foundation

enum NoteType: Int32, CaseIterable {
    case important = 1
    case todo = 2
    case simple = 3
    
    
}

enum NoteStatus: Int32, CaseIterable {
    case current = 1
    case archived = 2
    case deleted = 3
}

protocol NoteProtocol {
    var title: String { get set }
    var content: String { get set }
    var typeValue: Int32 { get set }
    var statusValue: Int32 { get set }
    var date: Date { get set }
}

class Note: NoteProtocol {
    var title: String
    var content: String
    var typeValue: Int32
    var statusValue: Int32
    var date: Date
    
    init(title: String, content: String, typeValue: Int32, statusValue: Int32, date: Date) {
        self.title = title
        self.content = content
        self.typeValue = typeValue
        self.statusValue = statusValue
        self.date = date
    }
}

extension Note {
    var type: NoteType {
        get {
            return NoteType(rawValue: self.typeValue)!
        }
        set {
            self.typeValue = Int32(newValue.rawValue)
        }
    }
    var status: NoteStatus {
        get {
            return NoteStatus(rawValue: self.statusValue)!
        }
        set {
            self.statusValue = Int32(newValue.rawValue)
        }
    }
}
