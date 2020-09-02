//
//  CurrentUserState.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/18.
//

import Foundation
import Combine
import SwiftUI
import Alamofire
class CurrentUserStore: ObservableObject,PersistentDataStore {
    public static let shared = CurrentUserStore()

    @Published var users:[String:User] = [:]
    @Published public var username:String = ""
    @Published public var usersFollowed:[String:Bool] = [:]
    @Published public var followers:[String:[Owner]] = [:]
    @Published public var followings:[String:[Owner]] = [:]
    struct UserStoreModel:Codable {
        var user:User?
        var userEvents:[String:[UserEvent]]?
        var orgList:[String:[Org]]?
        var repos:[String:[Repo]]?
    }
    let persistentedDataFileName: String = "UserData"
    typealias DataType = UserStoreModel?
    
    private var disposeBag:[AnyCancellable] = []
    private func persist(){
        let userStoreModel = UserStoreModel(user: currentUser, userEvents: userEvents,orgList: orgList,repos: repos)
        persistData(data: userStoreModel)
    }
    @Published public var currentUser:User?{
        didSet{
            username = currentUser?.login ?? ""
            persist()
        }
    }
    
    @Published var orgList:[String:[Org]] = [:]{
        didSet{
            persist()
        }
    }
    @Published var userEvents:[String:[UserEvent]] = [:]{
        didSet{
            persist()
        }
    }
    
    @Published var repos:[String:[Repo]] = [:]{
        didSet{
            persist()
        }
    }
    init() {
        /// 从内存中获取user信息
        if let data = getPersistData(){
            self.currentUser = data?.user
            self.username = data?.user?.login ?? ""
            self.userEvents = data?.userEvents ?? [:]
            self.orgList = data?.orgList ?? [:]
            self.repos = data?.repos ?? [:]
        }
        let cancellable =  AuthClient.shared.$authStatus.combineLatest(AuthClient.shared.$headers).sink{
            switch $0.0{
            case .authenthicated(authToken: _):
                if $0.1 != nil{
                    self.fetchMine()
                }
            case .signnedOut:
                self.currentUser = nil
            default:
                break
            }
        }
        disposeBag.append(cancellable)
    }
    /// fetch me
    public func fetchMine(){
        let cancellable = User.fetchMe().sink(receiveCompletion: {error in
            if case .failure(let err) = error{
                print("fetch me error is \(err)")
                UIState.shared.toast = (true,err.localizedDescription)
            }else{
                print("fetch me finished")
            }
        }, receiveValue: {user in
            self.currentUser = user
            CurrentUserStore.shared.fetchEvents(username: user.login!, page: 1)
        })
        self.disposeBag.append(cancellable)
    }
    
    /// fetch Events
    /// - Parameters:
    ///   - username: <#username description#>
    ///   - page: <#page description#>
    public func fetchEvents(username:String,page:Int){
        let cancellable = User.userEvents(username: username, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {error in
                if case .failure(let err) = error{
                    print("fetch events error is \(err)")
                }else{
                    print("fetch events finished")
                }
            }, receiveValue: {events in
                self.userEvents[username] = events
            })
        self.disposeBag.append(cancellable)
        
    }
    public func userEvents(username:String){
        let cancellable = User.userEvents(userLogin:username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {error in
                if case .failure(let err) = error{
                    print("user events error is \(err)")
                }else{
                    print("user events finished")
                }
            }, receiveValue: {events in
                self.userEvents[username] = events
            })
        self.disposeBag.append(cancellable)
        
    }
    
    func getUserInfo(login:String){
        let cancellable = User.getUserInfo(login: login)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {error in
                if case .failure(let err) = error{
                    print("getUserInfo error is \(err)")
                }else{
                    print("getUserInfo finished")
                }
            }, receiveValue: {usr in
                self.users[login] = usr
                self.checkIfFollowing(userLogin: usr.login!)
            })
        self.disposeBag.append(cancellable)
    }
    func follow(login:String,method:HTTPMethod){
        let cancellable = User.follow(login: login,method:method).sink(receiveCompletion: {error in
            if case .failure(let err) = error{
                print("follow error is \(err)")
            }else{
                print("follow finished")
            }
        }, receiveValue: {finished in
            if finished{
                self.usersFollowed[login]?.toggle()
            }
        })
        self.disposeBag.append(cancellable)
    }
    func checkIfFollowing(userLogin:String){
        let cancellable = User.checkIfFollowing(selfLogin: currentUser!.login!, userLogin: userLogin)
            .sink(receiveCompletion: {error in
                if case .failure(let err) = error{
                    print("checkIfFollowing error is \(err)")
                }else{
                    print("checkIfFollowing finished")
                }
            }) { followed in
                self.usersFollowed[userLogin] = followed
            }
        self.disposeBag.append(cancellable)
    }
    func orgList(userLogin:String){
        let cancellable = User.orgList(userLogin: userLogin)
            .sink(receiveCompletion: {error in
                if case .failure(let err) = error{
                    print("orgList error is \(err)")
                }else{
                    print("orgList finished")
                }
            }, receiveValue: {value in
                self.orgList[userLogin] = value
            })
        disposeBag.append(cancellable)
    }
    func repos(login:String){
        let cancellable = User.repos(userLogin: login)
            .sink(receiveCompletion: {error in
                if case .failure(let err) = error{
                    print("repos error is \(err)")
                }else{
                    print("repos finished")
                }
            }, receiveValue: {value in
                self.repos[login] = value
            })
        disposeBag.append(cancellable)
    }
    
    func followers(login:String){
        let cancellable = User.followers(userLogin: login)
            .sink(receiveCompletion: {result in
                if case .failure(let err) = result{
                    print("followers error is \(err)")
                }else{
                    print("followers finished")
                }
            }, receiveValue: {owners in
                self.followers[login] = owners
            })
        disposeBag.append(cancellable)
    }
    
    func followings(login:String){
        let cancellable = User.followings(userLogin: login)
            .sink(receiveCompletion: {result in
                if case .failure(let err) = result{
                    print("followings error is \(err)")
                }else{
                    print("followings finished")
                }
            }, receiveValue: {owners in
                self.followings[login] = owners
            })
        disposeBag.append(cancellable)
    }
}
