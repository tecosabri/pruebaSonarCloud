//
//  NetworkFetching.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 28/7/23.
//

import Foundation
import Combine


protocol NetworkFetching {
    
    /// /// Creates a publisher with types Data and Error treating the httpurl errors.
    /// - Parameter request: The fetch request.
    /// - Returns: A  <Data, Error>  without HTTPUrl errors.
    func load(_ request: URLRequest) -> AnyPublisher<Data, Error>
}
