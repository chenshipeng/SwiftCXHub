//
//  PersistentDataStore.swift
//  SwiftCXHub
//
//  Created by chenshipeng on 2020/8/12.
//

import Foundation
fileprivate let decoder = JSONDecoder()
fileprivate let encoder = JSONEncoder()
fileprivate let saving_queue = DispatchQueue(label:"SwiftCXHub.savingqueue",qos: .background)

protocol PersistentDataStore {
    associatedtype DataType:Codable
    var persistentedDataFileName:String{get}
    func persistData(data:DataType)
    func getPersistData() -> DataType?
}
extension PersistentDataStore{
    func persistData(data:DataType){
        saving_queue.async {
            do{
                let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor:nil,create:false)
                    .appendingPathComponent(persistentedDataFileName)
                let archive = try encoder.encode(data)
                try archive.write(to: filePath, options: .atomicWrite)
            }catch let error{
                print("Error while saving:\(error.localizedDescription)")
            }
        }
    }
    
    func getPersistData() -> DataType?{
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            if let data = try? Data(contentsOf: filePath){
                return try decoder.decode(DataType.self, from: data)
            }
        } catch let error {
            print("Error while loading: \(error.localizedDescription)")
        }
        return nil
    }
}
