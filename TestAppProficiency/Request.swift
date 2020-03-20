//
//  Request.swift/Users/user167484/Desktop/TestAppProficiencySwift/TestAppProficiency/data.json
//  TestAppProficiency
//
//  Created by user167484 on 3/19/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

extension Data: Codable {}
enum Request {
    case fetchData
    case fetchImage(url: String)
    
    typealias RequestCompletion<T> = (_ response: URLResponse?, _ data: T) -> Void
    typealias ImageCompletion = (_ response: URLResponse?, _ data: Data) -> Void
    typealias FailureCompletion = (_ error: Error) -> Void
    
    var url: URL {
        switch self {
        case .fetchData:
            return Bundle.main.url(forResource: "data", withExtension: "json")!
        case .fetchImage(let urlString):
            return URL(string: urlString)!
        }
    }
    
    
    
    func execute(success: @escaping ImageCompletion, failure: @escaping FailureCompletion) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
            } else {
                guard let data = data else { return }
                switch self {
                case .fetchImage:
                    DispatchQueue.main.async {
                        success(response, data)
                    }
                default: break
                }
            }
        }.resume()
    }
    
    func execute<T: Decodable>(success: @escaping RequestCompletion<T>, failure: @escaping FailureCompletion) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
            } else {
                guard let data = data else { return }
                switch self {
                case .fetchData:
                    do {
                        let decoder = JSONDecoder()
                        let newData = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            success(response, newData)
                        }
                    } catch let error {
                        print("Caught Error - > \(error)")
                        DispatchQueue.main.async {
                            failure(error)
                        }
                        
                    }
                default: break
                }
            }
        }.resume()
    }
}

