//
//  RootView.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootviewModel: RootViewModel
    
    var body: some View {
        switch (rootviewModel.status) {
        case Status.none:
            LoginView() //login
            
        case Status.loading:
            Text("Loading")
            
        case Status.error(error: let errorString):
            Text("Error \(errorString)")
            
        case Status.loaded:
            TabView {
                HomeView(homeViewModel: HomeViewModel(repository: rootviewModel.repository))
                    .tabItem {
                        Image("tab1")
                        Text("First")
                    }
                
                SettingsView()
                    .tabItem {
                        Image("tab2")
                        Text("Second")
                    }
            }

            
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel(repository: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl())))
    }
}
