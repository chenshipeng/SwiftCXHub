//
//  AppGroupShareDataStore.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/10.
//

import Foundation
fileprivate let decoder = JSONDecoder()
fileprivate let encoder = JSONEncoder()
fileprivate let saving_queue = DispatchQueue(label:"SwiftCXHub.appGroupShareQueue",qos: .background)

protocol AppGroupShareDataStore {
    associatedtype DataType:Codable
    var persistentedDataFileName:String{get}
    func persistData(data:DataType)
    func getPersistData() -> DataType?
}
extension AppGroupShareDataStore{
    func persistData(data:DataType){
        saving_queue.async {
            if let filePath =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.csp.SwiftCXhub.com")?.path
            {
                var url = URL(fileURLWithPath: filePath)
                url.appendPathComponent("/Library/UserData", isDirectory: false)
                do{
                    
                    let archive = try encoder.encode(data)
                    try archive.write(to: url, options: .atomicWrite)
                }catch let error{
                    print("Error while saving:\(error.localizedDescription)")
                }
            }
            
        }
    }
    
    func getPersistData() -> DataType?{
        if let filePath =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.csp.SwiftCXhub.com")?.path
        {
            var url = URL(fileURLWithPath: filePath)
            url.appendPathComponent("/Library/UserData", isDirectory: false)
            do {
                
                if let data = try? Data(contentsOf: url){
                    return try decoder.decode(DataType.self, from: data)
                }
            } catch let error {
                print("Error while loading: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}
