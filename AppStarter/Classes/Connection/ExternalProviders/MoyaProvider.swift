//
//  MoyaProvider.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation
import Moya

extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = String(data: data, encoding: String.Encoding.utf8) else { return nil }
        
        return prettyPrintedString
    }
}

public class MoyaApiProvider: ApiProviderProtocol {
    
    let provider: MoyaProvider<Connection> = MoyaProvider()
    
    public init() {
        
    }
    
    public func makeRequest<SuccessModel, ErrorModel>(withRequestParams requestParams: HTTPRequestParamsProtocol, completion: @escaping (Response<SuccessModel, ErrorModel>) -> Void) where SuccessModel : Decodable, ErrorModel : Decodable {
        provider.request(.moyaRequest(request: requestParams)) { (result) in
            
            
            switch result {
            case let .success(response):
                if let printData = response.data.prettyPrintedJSONString {
                    print(printData)
                }
                if (200...299).contains(response.statusCode) {
                    do {
                        let resultDecoded = try JSONDecoder().decode(SuccessModel.self, from: response.data)
                        DispatchQueue.main.async { completion(.success(resultDecoded)) }
                    }
                    catch {
                        DispatchQueue.main.async { completion(.failure(nil, error)) }
                    }
                    return
                }
                break
            case let .failure(error):
                DispatchQueue.main.async { completion(.failure(nil, error)) }
                break
            }
        }
    }
}

enum Connection {
    case moyaRequest(request: HTTPRequestParamsProtocol)
}

extension Connection: TargetType {
    
    var baseURL: URL {
        switch self {
        case let .moyaRequest(request):
            return URL(string: request.url)!
        }
    }
    
    var path: String {
        switch self {
        case let .moyaRequest(request):
            return request.path ?? ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case let .moyaRequest(request):
            return request.method.getMoyaMethod()
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case let .moyaRequest(request):
            switch request.method {
            case .get:
                return .requestParameters(parameters: request.query ?? [:], encoding: URLEncoding(destination: .queryString))
            case .post:
                return .requestParameters(parameters: request.body ?? [:], encoding: JSONEncoding.default)
            default:
                return .requestPlain
            }
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

private extension HTTPMethod {
    func getMoyaMethod() -> Moya.Method {
        switch self {
        case .options:
            return .options
        case .get:
            return .get
        case .head:
            return .head
        case .post:
            return .post
        case .put:
            return .put
        case .patch:
            return .patch
        case .delete:
            return .delete
        case .trace:
            return .trace
        case .connect:
            return .connect
        }
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

public struct EmptyStruct: Decodable {
    
}
