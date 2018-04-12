//
//  API.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 22/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

//API components

enum ApiError: String, Error {
    
    case noResponse = "Couldn't get HTTP response"
    case noData = "No data returned"
    case badCode = "Wrong HTTP status code"
    case parse = "Not parsable JSON returned"
    case unknown = "Unknown Error"
    
    var message: String {
        return self.rawValue
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct ApiRequest {
    
    let endpoint: String
    let method: HTTPMethod
}

enum Result<V,E> {
    case success(V)
    case failure(E)
}

//API

class API: Gateway {
    
    private let defaultSession = URLSession(configuration: .default)
    
    func fetchAllItems(_ completion: @escaping (Result<[DataModel], ApiError>) -> Void) {
        let request = RequestBuilder.createUrlRequest(from: ApiRequest(endpoint: "items", method: .get))
        return send(request) { result in
            switch result {
            case .failure(let error):
                completion(Result.failure(error))
            case .success(let data):
                if let decodedResult = Decoder.mainDecoder.decode(data: data, to: [DataModel].self) {
                    completion(Result.success(decodedResult))
                } else {
                    completion(Result.failure(ApiError.parse))
                }
            }
        }
    }
    
    private func send(_ request: URLRequest, _ completion: @escaping (Result<Data, ApiError>) -> Void) {
        var result: Result<Data, ApiError> = Result.failure(ApiError.unknown)
        defaultSession.dataTask(with: request) { data, response, error in
            guard let HTTPResponse = response as? HTTPURLResponse else {
                result = Result.failure(ApiError.noResponse)
                completion(result)
                return
            }
            guard let data = data else {
                result = Result.failure(ApiError.noData)
                completion(result)
                return
            }
            if 200 ..< 300 ~= HTTPResponse.statusCode {
                result = Result.success(data)
                completion(result)
                return
            } else {
                result = Result.failure(ApiError.badCode)
                completion(result)
            }
            }.resume()
    }
}

//Request Builder

private struct ApiConfiguration {
    
    static let apiScheme = "http"
    static let apiHost = "192.168.0.101"
    static let port = 8080
    static let apiPath = "/api/"
}

private class RequestBuilder {
    
    static func createUrlRequest(from apiRequest: ApiRequest) -> URLRequest {
        let urlComponents = getUrlComponents(from: apiRequest)
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = apiRequest.method.rawValue
        return request
    }
    
    private static func getUrlComponents(from apiRequest: ApiRequest) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = ApiConfiguration.apiScheme
        urlComponents.host = ApiConfiguration.apiHost
        urlComponents.port = ApiConfiguration.port
        urlComponents.path = ApiConfiguration.apiPath + apiRequest.endpoint.replacingOccurrences(of: "%20", with: " ")
        return urlComponents
    }
}
