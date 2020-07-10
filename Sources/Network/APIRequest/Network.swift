import Combine
import Foundation

class Network {
    func loadData(withRequest request: APIRequestProtocol) -> AnyPublisher<Data, APIError> {
        return Future<Data, APIError> { promise in
            guard let urlRequest = request.urlRequest else {
                promise(.failure(APIError.apiError(reason: "URL Reques is broken")))
                return
            }
        
                        
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard
                    let code = (response as? HTTPURLResponse)?.statusCode,
                    let statusCode = HTTPStatusCode(rawValue: code) else {
                        promise(.failure(APIError.unknown))
                    return
                }
                
                guard let data = data else {
                    if let error = error {
                        promise(.failure(APIError.apiError(reason: error.localizedDescription)))
                    }
                    promise(.failure(APIError.unknown))

                    return
                }
                
                switch statusCode.responseType {
                case .success:
                    promise(.success(data))
                default:
                    // Other cases [300..500]
                    promise(.failure(APIError.apiError(reason: "\(statusCode.rawValue)")))
                }
            }.resume()
        }
        .eraseToAnyPublisher()
    }
}

