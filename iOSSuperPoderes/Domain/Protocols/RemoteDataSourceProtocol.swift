//
//  RemoteDataSourceProtocol.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol {
    func login(user: String, password: String) -> AnyPublisher<String, Error>
    func getHeroes(name: String) async throws -> [Hero]? 
}
