//
//  RepositoryImpl.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation
import Combine

final class RepositoryImpl: RepositoryProtocol {

    // MARK: - Properties
    private let remoteDataSource: RemoteDataSourceProtocol
    
    // MARK: - Init
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - Repository protocol functions
    func login(user: String, password: String) -> AnyPublisher<String, Error> {
        return remoteDataSource.login(user: user, password: password)
//            .sink(receiveCompletion: { completion in
//                switch completion { // Esto se ejecuta lo último!
//                case .failure(_):
//                    print("Failure saving the token")
//                case .finished:
//                    print("Finished login repository")
//                }
//            }, receiveValue: { token in
//                print(token)
//                self.save(token: token, forUser: user)
//            })
//            .store(in: &subscribers)
            .tryMap { token in
                self.save(token: token, forUser: user)
                return token
            }
            .eraseToAnyPublisher()
    }
    
    func getHeroes(name: String) async throws -> [Hero]? {
        return try? await remoteDataSource.getHeroes(name: name)
    }
    
    func save(token: String?, forUser user: String) {
        // Se obtiene el token como data, si no se puede convertir es que el string está corrupto
        guard let tokenData = token?.data(using: .utf8) else {
            print("Error converting the token to data")
            return
        }
        
        // Guardar
        KeyChainHelper.standard.save(data: tokenData, account: user)
    }
    
    func readToken(forUser user: String) -> String? {
        let savedTokenData = KeyChainHelper.standard.read(account: user)
        guard let savedTokenData else {
            print("ERROR reading")
            return nil
        }
        guard let tokenString = String(data: savedTokenData, encoding: .utf8) else {
            print("ERROR reading: data is not convertible")
            return nil
        }
        return tokenString
    }
}
