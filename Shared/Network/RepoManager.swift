//
//  RepoManager.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/20.
//

import Foundation
import SwiftUI
import Combine
import Alamofire
public class RepoManager: ObservableObject,PersistentDataStore {
    public static let shared = RepoManager()
    @Published public var repoDetails:[String:Repo] = [:]{
        didSet{
            let repoData = RepoData(repoDetails: repoDetails, repoStarred: repoStarred,repoEvents: repoEvents)
            persistData(data: repoData)
            
        }
    }
    @Published public var repoEvents:[String:[UserEvent]] = [:]{
        didSet{
            let repoData = RepoData(repoDetails: repoDetails, repoStarred: repoStarred,repoEvents: repoEvents)
            persistData(data: repoData)
            
        }
    }
    @Published public var repoStarred:[String:Bool] = [:]{
        didSet{
            let repoData = RepoData(repoDetails: repoDetails, repoStarred: repoStarred,repoEvents: repoEvents)
            persistData(data: repoData)
            
        }
    }
    @Published public var repoStarUserList:[String:[Owner]] = [:]
    @Published public var repoWatchersList:[String:[Owner]] = [:]
    @Published public var repoForksList:[String:[StarredModel]] = [:]
    @Published public var issuesList:[Int:[Issue]] = [:]
    @Published public var repoBranches:[Int:[Branch]] = [:]
    @Published public var commits:[String:[Commit]] = [:]
    private var disposeBags:[AnyCancellable] = []
    
    struct RepoData:Codable {
        var repoDetails:[String:Repo] = [:]
        var repoStarred:[String:Bool] = [:]
        var repoEvents:[String:[UserEvent]] = [:]
    }
    let persistentedDataFileName: String = "repoDataFileName"
    typealias DataType = RepoData
    
    
    init() {
        if let data = getPersistData(){
            repoDetails = data.repoDetails
            repoStarred = data.repoStarred
            repoEvents = data.repoEvents
        }
    }
    
    public func getRepoInfo(url:String){
        let publisher = repoInfo(url: url)
        let cancellable = publisher.sink(receiveCompletion: {error in
            if case .failure(let err) = error{
                print("repo info error is \(err)")
            }else{
                print("repo info finished")
            }
            
        }) { repo in
            self.repoDetails[url] = repo
            self.checkIfStarredRepo(owner: repo.owner!.login!, repoName: repo.name!, repoUrl: repo.url!)
        }
        disposeBags.append(cancellable)
    }
    private func repoInfo(url:String) -> AnyPublisher<Repo,AFError>{
        return API.shared.request(url: url, httpMethod: .get, params: nil)
    }
    public func getRepoEvents(url:String){
        let publisher = repoEvents(url: url)
        let cancellable = publisher.sink(receiveCompletion: {error in
            if case .failure(let err) = error{
                print("repo events error is \(err)")
            }else{
                print("repo events finished")
            }
            
        }) { event in
            self.repoEvents[url] = event
        }
        disposeBags.append(cancellable)
    }
    private func repoEvents(url:String) ->AnyPublisher<[UserEvent],AFError>{
        return API.shared.request(url: url, httpMethod: .get, params: nil)
    }
    
    func checkIfStarredRepo(owner:String,repoName:String,repoUrl:String){
        let cancellable = User.checkIfStarredRepo(owner: owner, repoName: repoName,method: .get).sink(receiveCompletion: {result in }, receiveValue: {starred in
            self.repoStarred[repoUrl] = starred
        })
        disposeBags.append(cancellable)
    }
    
    func starRepo(owner:String,repoName:String,repoUrl:String,method:HTTPMethod){
        let cancellable = User.checkIfStarredRepo(owner: owner, repoName: repoName,method: method).sink(receiveCompletion: {result in }, receiveValue: {finished in
            if finished{
                self.repoStarred[repoUrl]?.toggle()
            }
        })
        disposeBags.append(cancellable)
    }
    
    func repoStarsUserList(repo:Repo){
        let cancellable = repo.starUserList()
            .sink(
                receiveCompletion: {result in
                    if case .failure(let err) = result{
                        print("repoStarsUserList error is \(err)")
                    }else{
                        print("repoStarsUserList finished")
                    }
                },
                receiveValue: {owners in
                    self.repoStarUserList[repo.stargazers_url!] = owners
            })
        disposeBags.append(cancellable)
    }
    
    func repoForksUserList(repo:Repo){
        let cancellable = repo.forksUserList()
            .sink(receiveCompletion: {result in
                if case .failure(let err) = result{
                    print("repoForksUserList error is \(err)")
                }else{
                    print("repoForksUserList finished")
                }
            }, receiveValue: {users in
                self.repoForksList[repo.forks_url!] = users
            })
        disposeBags.append(cancellable)
    }
    
    func repoWatchersUserList(repo:Repo){
        let cancellable = repo.watchersUserList()
            .sink(receiveCompletion: {result in
                if case .failure(let err) = result{
                    print("repoWatchersUserList error is \(err)")
                }else{
                    print("repoWatchersUserList finished")
                }
            }, receiveValue: {users in
                self.repoWatchersList[repo.subscribers_url!] = users
            })
        disposeBags.append(cancellable)
    }
    func issues(repo:Repo){
        let cancellable = repo.issues()
            .sink(receiveCompletion: {result in
                if case .failure(let err) = result{
                    print("issues error is \(err)")
                }else{
                    print("issues finished")
                }
            }, receiveValue: {issues in
                self.issuesList[repo.id!] = issues
            })
        disposeBags.append(cancellable)
    }
    func branches(repo:Repo){
        let cancellable = repo.branches()
            .sink(receiveCompletion: {result in
                if case .failure(let err) = result{
                    print("branches error is \(err)")
                }else{
                    print("branches finished")
                }
            }, receiveValue: {branches in
                self.repoBranches[repo.id!] = branches
            })
        disposeBags.append(cancellable)
    }
    func commits(repo:Repo,branch:Branch){
        let cancellable = repo.commits(branch: branch)
            .sink(receiveCompletion: {result in
                if case .failure(let err) = result{
                    print("commits error is \(err)")
                }else{
                    print("commits finished")
                }
            }, receiveValue: {commits in
                self.commits["\(repo.id!)\(branch.commit!.sha!)"] = commits
            })
        disposeBags.append(cancellable)
    }
}
extension Repo{
    public func starUserList()->AnyPublisher<[Owner],AFError>{
        return API.shared.request(url: self.stargazers_url!,httpMethod: .get, params: nil)
    }
    public func forksUserList()->AnyPublisher<[StarredModel],AFError>{
        return API.shared.request(url: self.forks_url!,httpMethod: .get, params: nil)
    }
    public func watchersUserList()->AnyPublisher<[Owner],AFError>{
        return API.shared.request(url: self.subscribers_url!,httpMethod: .get, params: nil)
    }
    public func issues()->AnyPublisher<[Issue],AFError>{
        return API.shared.request(endpoint: RepoEndPoint.issues(repo: self), params: nil)
    }
    public func branches()->AnyPublisher<[Branch],AFError>{
        return API.shared.request(endpoint: RepoEndPoint.branches(repo: self), params: nil)
    }
    public func commits(branch:Branch)->AnyPublisher<[Commit],AFError>{
        return API.shared.request(endpoint: RepoEndPoint.commits(repo: self, branch: branch), params: nil)
    }
}
