//
//  DirectryModel.swift
//  XTNotebook
//
//  Created by xc on 2022/12/7.
//

import UIKit
import WCDBSwift

let directry_model  = "DirectryModel"


class DirectryModel: TableCodable {

    
    var date : String = ""
    var title : String = ""
    var identifier : Int? = nil

    enum CodingKeys : String,CodingTableKey {
        
        typealias Root = DirectryModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case identifier
        case title
        case date
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [identifier:ColumnConstraintBinding(isPrimary: true,isAutoIncrement: true)]
        }
        
    }
    
}
