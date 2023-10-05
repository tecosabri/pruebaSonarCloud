//
//  iOSSuperPoderesApp.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 23/7/23.
//

import SwiftUI

@main
struct iOSSuperPoderesApp: App {
    var body: some Scene {
        WindowGroup {
            let remoteDataSource = RemoteDataSourceImpl()
            let repository = RepositoryImpl(remoteDataSource: remoteDataSource)
            RootView()
                .environmentObject(RootViewModel(repository: repository))
        }
    }
}
