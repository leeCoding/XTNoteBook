//
//  RequestManager.swift
//  XTNotebook
//
//  Created by Li on 2022/8/16.
//

import UIKit
import Alamofire

class RequestManager: NSObject {

    static func postRequest(completion: @escaping (Result<[Any],AFError>) -> Void) {
        
        AF.request("http://127.0.0.1:5000").responseString { responseString in
            
            switch responseString.result {
            case .success(let string):
                
                debugPrint(string);
                completion(.success([string]))
                break
                
            case .failure(let error):
                debugPrint("错误: \(error)");
                completion(.failure(error))
                break
            }
        
        }
    }
    
    
    
    
}
