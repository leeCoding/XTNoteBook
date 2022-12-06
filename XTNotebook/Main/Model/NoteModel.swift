//
//  NoteModel.swift
//  XTNotebook
//
//  Created by Li on 2022/7/29.
//

import UIKit
import WCDBSwift

let noteModelTableName  = "NoteModel"

class NoteModel: TableCodable {
    
    var identifier : Int? = nil
    var title : String = ""
    var content : String = ""
    var date : String = ""
    //required init(){}

    enum CodingKeys : String,CodingTableKey {
        
        typealias Root = NoteModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case identifier
        case title
        case content
        case date
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [identifier:ColumnConstraintBinding(isPrimary: true,isAutoIncrement: true)]
        }
        
    }
    
}
