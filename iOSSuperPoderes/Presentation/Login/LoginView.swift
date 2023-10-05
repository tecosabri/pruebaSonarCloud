//
//  ContentView.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 23/7/23.
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        
        ZStack{
            // Imagen de Fondo
            Image(decorative: "fondo2")
                .resizable()
                .opacity(1)
            
            // MARK: - User mail, password y button
            VStack{
                
                // MARK: - User mail y password
                VStack{
                    TextField("User mail", text: self.$email)
                        .padding(10.5)
                        .multilineTextAlignment(.center)
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .cornerRadius(8.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    Spacer()
                    
                    SecureField("Password", text: self.$password)
                        .padding(10.5)
                        .multilineTextAlignment(.center)
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .cornerRadius(8.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .frame(width: 272, height: 112)
                .padding([.leading, .trailing], 59)
                
                
                Spacer()
                
                
                // MARK: - Button
                Button(action: {
                    print("Login click")
                    rootViewModel.onLogin(withUser: "bejl@keepcoding.es", andPassword: "123456")
                    
                }) {
                    Text("Login")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 138, height: 40)
                        .background(Color(uiColor: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)))
                        .cornerRadius(8.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }
            }
            .frame(width: 272, height: 216)

        }
        .ignoresSafeArea()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
