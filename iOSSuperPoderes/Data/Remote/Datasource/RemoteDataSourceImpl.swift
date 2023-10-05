//
//  RemoteDataSource.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation
import Combine

enum NetworkError: Error, Equatable {
    case malformedURL
    case noData
    case errorCode(Int?)
    case tokenFormat
    case noUser
    case other
}

final class RemoteDataSourceImpl: RemoteDataSourceProtocol {
    
    // MARK: - Properties
    private let session: NetworkFetching
    private let server: String = "https://dragonball.keepcoding.education/"
    
    init(session: NetworkFetching = URLSession.shared) {
        self.session = session
    }
    
    func login(user: String, password: String) -> AnyPublisher<String, Error> {
        // Obtenemos la session del login
        guard let sessionLogin = getSessionLogin(user: user, password: password) else {
            return Fail<String, Error>(error: NetworkError.malformedURL)
                .eraseToAnyPublisher()
        }
        // Creamos un publisher de URLSession.shared que empieza a tratar la respuesta
        return session.load(sessionLogin)
            .tryMap{ data in
                // After testing (session.load) returns data directly
//                guard let httpResponse = response.response as? HTTPURLResponse,
//                      httpResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
                guard let token = String(data: data, encoding: .utf8) else {
                    throw NetworkError.tokenFormat
                }
                // If the response is successful return data (token) as a String
                return token
            }
            .receive(on: DispatchQueue.main) // Indispensable porque va a actualizar algo que cambia la UI
            .eraseToAnyPublisher() // Permite trabajar con un publisher AnyPublisher<String, Error> en lugar de Publishers.TryMap<URLSession.DataTaskPublisher, String>.
    }
    
    func getHeroes(name: String) async throws -> [Hero]? {
        // Get the url
        guard let url = getSessionHeroes(name: "") else {
            throw NetworkError.malformedURL
        }
        // Get the data
        let (heroesData, _) = try await URLSession.shared.data(for: url)
        // Decode the data
        guard let heroes = try? JSONDecoder().decode([Hero].self, from: heroesData) else {
            print("Error: error while decoding the response from the server")
            return nil
        }
        return heroes
    }
}


// MARK: - URLRequest methods
extension RemoteDataSourceImpl {
    
    func getSessionLogin(user:String, password:String) -> URLRequest? {
        // Basic authentication user:password -> base64
        let loginString = String(format: "%@:%@", user, password) // user:password
        // let loginString = "\(user):\(password)"
        let loginData = loginString.data(using: .utf8)
        guard let base64loginString = loginData?.base64EncodedString() else {
            return nil
        }
        
        // Get URL request:
        // Get URL
        guard let url = URL(string: "\(server)/api/auth/login") else {
            print("Error: invalid URL")
            return nil
        }
        
        // Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Post -> debería ser get
        request.setValue("Basic \(base64loginString)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func getSessionHeroes(name: String) -> URLRequest?{
        // Get URL request:
        // Get URL
        guard let url = URL(string: "\(server)/api/heros/all") else {
            print("Error: invalid URL")
            return nil
        }
        
        guard let user = UserDefaultsHelper.defaults.readUser() else {
            print("Error: can not save user in user defaults")
            return nil
        }

        guard let tokenData = KeyChainHelper.standard.read(account: user) else {
            print("Error: unable to read the token stored in keychain")
            return nil
        }
        // Get token
        guard let token = String(data: tokenData, encoding: .utf8) else {
            print("Error: invalid token format")
            return nil
        }
        
        // URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Get body
        struct Body: Encodable {
            let name: String
        }
        let body = Body(name: name)
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        return urlRequest
    }
}
