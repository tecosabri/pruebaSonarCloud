//
//  RootViewModel.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import Foundation
import Combine

enum Status {
    case none, loading, loaded, error(error:String)
}

final class RootViewModel: ObservableObject {
    
    // MARK: Properties
    let repository: RepositoryProtocol
    var subscribers: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Published
    @Published var status = Status.none
    
    // MARK: - Init
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    

    // MARK: - Login method
    func onLogin(withUser user: String, andPassword password: String) {
        // Iniciamos con status loading
        status = .loading
        
        repository.login(user: user, password: password)
            .sink(receiveCompletion: { completion in
                switch completion { // Esto se ejecuta lo último!
                case .failure(_):
                    print("Failure while login")
                    self.status = .error(error: "Error while login")
                case .finished:
                    print("Login finished")
                    self.status = .loaded
                }
            }, receiveValue: { token in
                guard let data = token.data(using: .utf8) else {
                    print("Token couldn't be saved into keychain")
                    return
                }
                // ESTO NO SIGUE SOLID, TENDRÍAMOS QUE DECLARAR LOS MÉTODOS EN EL REPOSITORIO
                KeyChainHelper.standard.save(data: data, account: user) // Sustituir por métodos del repositorio si hay tiempo
                UserDefaultsHelper.defaults.save(user: user)
                print(token)
            })
            .store(in: &subscribers)

    }
    
}
