//
//  HttpConnectionProtocol.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

public enum Response<SuccessModel: Decodable, ErrorModel: Decodable> {
    case success(SuccessModel)
    case failure(ErrorModel?, Error)
}

public protocol ApiProviderProtocol: class {
    func makeRequest<SuccessModel: Decodable, ErrorModel: Decodable>(withRequestParams requestParams: HTTPRequestParamsProtocol,
                                                                     completion: @escaping(Response<SuccessModel, ErrorModel>) -> Void)
}

public protocol HTTPRequestParamsProtocol {
    var url: String { get set }
    var method: HTTPMethod { get set }
    var query: [String: Any]? { get set }
    var path: String? { get set }
    var header: [String: Any]? { get set }
    var body: [String: Any]? { get set }
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
