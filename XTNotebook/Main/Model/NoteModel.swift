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
    
    var identifier: Int? = nil
    var title : String = ""
    var content : String = ""
    var date : String = ""

    required init(){}

    enum CodingKeys : String,CodingTableKey {
        
        static var objectRelationalMapping = TableBinding(CodingKeys.self)
        typealias Root = NoteModel

        case title
        case content
        case date
    }

    static let objectRelatingMapping = TableBinding(CodingKeys.self)

    static var columnConstraintBindings : [CodingKeys: ColumnConstraintBinding]? {
        return [.date:ColumnConstraintBinding(isPrimary:true,isAutoIncrement:false)]
    }

}
