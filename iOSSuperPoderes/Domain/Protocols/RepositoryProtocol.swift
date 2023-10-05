//
//  RepositoryProtocol.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation
import Combine

protocol RepositoryProtocol {
    func login(user: String, password: String) -> AnyPublisher<String, Error>
    func getHeroes(name: String) async throws -> [Hero]? 
}
