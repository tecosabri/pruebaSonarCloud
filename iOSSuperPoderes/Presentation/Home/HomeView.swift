//
//  HomeView.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var rootviewModel: RootViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        NavigationView {

            List(homeViewModel.heroes) { hero in
                HeroCellView(hero: hero)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Heroes")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel(repository: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl())))
    }
}
