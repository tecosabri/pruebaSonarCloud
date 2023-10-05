//
//  HomeViewModel.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    // MARK: Properties
    private let repository: RepositoryProtocol
    
    // MARK: - Published
    @Published var heroes: [Hero] = []
    
    // MARK: - Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
        DispatchQueue.main.async {
            Task {
                guard let apiHeroes = try? await repository.getHeroes(name: "") else {
                    self.heroes = []
                    print("Unable to get heroes")
                    return
                }
                self.heroes = apiHeroes
            }
        }
    }

    
}
