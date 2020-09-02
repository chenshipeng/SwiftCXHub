//
//  CurrentUserState.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/18.
//

import Foundation
import Combine
import SwiftUI
class CurrentUserStore: ObservableObject,PersistentDataStore {
    public static let shared = CurrentUserStore()

    @Published public var user:User?{
        didSet{
            if user != nil{
                persistData(data: user!)
            }
            
        }
    }
    let persistentedDataFileName: String = "UserData"
    typealias DataType = User
    
    private var disposeBag:[AnyCancellable] = []

    
    init() {
        /// 从内存中获取user信息
        if let data = getPersistData(){
            self.user = data
        }
    }
    /// 获取本人的信息
    public func fetchMine(){
        let cancellable = User.fetchMe().sink(receiveCompletion: {error in
            if case .failure(let err) = error{
                print("fetch me error is \(err.localizedDescription)")
            }else{
                print("fetch me finished")
            }
        }, receiveValue: {user in
            self.user = user
        })
        self.disposeBag.append(cancellable)
    }
}
