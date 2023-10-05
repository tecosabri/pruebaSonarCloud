//
//  SettingsView.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 25/7/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        Button(action: {
            rootViewModel.status = .none
        }, label: {
            Text("Log out")
        })
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
