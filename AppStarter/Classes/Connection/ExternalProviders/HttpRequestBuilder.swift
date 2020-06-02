//
//  HttpRequestBuilder.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

public struct Request: HTTPRequestParamsProtocol {
    public var url: String
    public var method: HTTPMethod
    public var query: [String: Any]?
    public var path: String?
    public var header: [String: Any]?
    public var body: [String: Any]?
}

public class RequestBuilder {
    
    private var url: String
    private var method: HTTPMethod
    private var query: [String: Any]?
    private var path: String?
    private var header: [String: Any]?
    private var body: [String: Any]?
    
    public init(withUrl url: String, andMethod method: HTTPMethod) {
        self.url = url
        self.method = method
    }
    
    public func withQuery(_ query: [String: Any]) -> RequestBuilder {
        self.query = query
        return self
    }
    
    public func withPath(_ path: String) -> RequestBuilder {
        self.path = path
        return self
    }
    
    public func withHeader(_ header: [String: Any]) -> RequestBuilder {
        self.header = header
        return self
    }
    
    public func addHeader(key: String, value: String) -> RequestBuilder {
        self.header?[key] = value
        return self
    }
    
    public func withBody(_ body: [String: Any]) -> RequestBuilder {
        self.body = body
        return self
    }
    
    public func create() -> Request {
        return Request(url: url,
                       method: method,
                       query: query,
                       path: path,
                       header: header,
                       body: body)
    }
}

