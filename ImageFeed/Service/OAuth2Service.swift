//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Muller Alexander on 17.08.2023.
//

import UIKit

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

final class OAuth2Service {
    static let shared = OAuth2Service()
    private let urlSession = URLSession.shared
    
    private (set) var authToken: String? {
        get {
            return OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
    private var task: URLSessionTask?
    private var lastCode: String?
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        if lastCode == code { return }
        task?.cancel()
        lastCode = code
        
        let request = makeAuthTokenRequest(code: code)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let body):
                    let authToken = body.accessToken
                    self.authToken = authToken
                    completion(.success(authToken))
                case .failure(let error):
                    completion(.failure(error))
                }
                self.task = nil
            }
        }
        self.task = task
        task.resume()
    }
}


extension OAuth2Service {
    private func object(
        for request: URLRequest,
        completion: @escaping (Result<OAuthTokenResponseBody, Error>) -> Void
    ) -> URLSessionTask {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return urlSession.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap { data -> Result<OAuthTokenResponseBody, Error> in
                Result { try decoder.decode(OAuthTokenResponseBody.self, from: data) }
            }
            completion(response)
        }
    }
    
    var selfProfileRequest: URLRequest {
        URLRequest.makeHTTPRequest(path: "/me", httpMethod: "GET")
    }
    
    func profileImageURLRequest(username: String) -> URLRequest {
        URLRequest.makeHTTPRequest(path: "/users/\(username)", httpMethod: "GET")
    }
    
    func photosRequest(page: Int, perPage: Int) -> URLRequest {
        URLRequest.makeHTTPRequest(path: "/photos?"
                                   + "page=\(page)"
                                   + "&&per_page=\(perPage)", httpMethod: "GET"
        )
    }
    
    func likeRequest(photoId: String) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "/photos/\(photoId)/like",
            httpMethod: "POST"
        )
    }
    
    func unlikeRequest(photoId: String) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "/photos/\(photoId)/like",
            httpMethod: "DELETE"
        )
    }
    
    func makeAuthTokenRequest(code: String) -> URLRequest {
        guard let url = URL(string: "https://unsplash.com") else { preconditionFailure("Cannot make url")}
        
        return URLRequest.makeHTTPRequest(
            path: "/oauth/token"
            + "?client_id=\(accessKey)"
            + "&&client_secret=\(secretKey)"
            + "&&redirect_uri=\(redirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            httpMethod: "POST",
            baseURL: url
        )
    }
}
