import Foundation

typealias CodableAPIRequest = DecodableAPIRequest & EncodableAPIRequest

protocol DecodableAPIRequest: APIRequest {
    associatedtype Response: Decodable
}

protocol BaseAPIRequest {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}

protocol APIRequest: BaseAPIRequest {
    func urlRequest(with host: String, authentication: Authentication) throws -> URLRequest
}

protocol EncodableAPIRequest: APIRequest, Encodable {
    func urlRequest(with host: String, encoder: URLEncodedFormEncoder, authentication: Authentication) throws -> URLRequest
}

extension EncodableAPIRequest {

    func urlRequest(with host: String, authentication: Authentication) throws -> URLRequest {
        let fullPath = URLRequest.fullPath(with: host, path: path)
        guard let url = URL(string: fullPath) else {
            throw APIClientError(code: .urlCreating)
        }

        // Create URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.setUrlEncpodedContentType()
        urlRequest.setHTTPMethod(httpMethod)
        urlRequest.setAuthentication(authentication)

        return urlRequest
    }

    func urlRequest(with host: String, encoder: URLEncodedFormEncoder, authentication: Authentication) throws -> URLRequest {
        var urlRequest = try urlRequest(with: host, authentication: authentication)
        if httpMethod != .GET && httpMethod != .DELETE {
            try urlRequest.setUrlEncodedContent(self, encoder: encoder)
        }
//        if httpMethod = .GET {
//            urlRequest.
//            try
//        }
        return urlRequest
    }
}
