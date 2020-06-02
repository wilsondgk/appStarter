//
//  HttpRequestBuilder.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

struct Request: HTTPRequestParamsProtocol {
    var url: String
    var method: HTTPMethod
    var query: [String: Any]?
    var path: String?
    var header: [String: Any]?
    var body: [String: Any]?
}

class RequestBuilder {
    
    var url: String
    var method: HTTPMethod
    var query: [String: Any]?
    var path: String?
    var header: [String: Any]?
    var body: [String: Any]?
    
    init(withUrl url: String, andMethod method: HTTPMethod) {
        self.url = url
        self.method = method
    }
    
    func withQuery(_ query: [String: Any]) -> RequestBuilder {
        self.query = query
        return self
    }
    
    func withPath(_ path: String) -> RequestBuilder {
        self.path = path
        return self
    }
    
    func withHeader(_ header: [String: Any]) -> RequestBuilder {
        self.header = header
        return self
    }
    
    func addHeader(key: String, value: String) -> RequestBuilder {
        self.header?[key] = value
        return self
    }
    
    func withBody(_ body: [String: Any]) -> RequestBuilder {
        self.body = body
        return self
    }
    
    func create() -> Request {
        return Request(url: url,
                       method: method,
                       query: query,
                       path: path,
                       header: header,
                       body: body)
    }
}

