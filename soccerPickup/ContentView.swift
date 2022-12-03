//
//  ContentView.swift
//  soccerPickup
//
//  Created by David Rusnak on 12/3/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var isLoggedIn = false
    var body: some View {
        if (isLoggedIn) {
            AppHome()
        } else {
            Welcome(isLoggedIn: $isLoggedIn)
            
        }
    }
}

struct AppHome: View {
    var body: some View {
        VStack {
            Text("Home screen")
        }
        
    }
}

struct Welcome: View {
    @State public var email = ""
    @State public var password = ""
    @State public var activeScreen = "welcome"
    @Binding var isLoggedIn : Bool
    
    // Put this into a separate style file????
    public var buttonRadius = 6
    public var loginScreenButtonWidth = 200.0
    public var loginScreenButtonHeight = 50.0
    public var title = "Welcome to Pick^"
    public var createAccount = "Create an Account"
    
    func loginHandle() {
        print("login handle")
        self.isLoggedIn = true;
    }
    
    func createHandle() {
        print("create account handle")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    TextField("Email", text: $email).autocapitalization(.none).autocorrectionDisabled(true).padding()
                    
                    SecureField("Password", text: $password).padding()
                    
                    if (email.count > 0 && password.count > 0) {
                          
                        Button(action: loginHandle) {
                            Text("Login")
                                .frame(width: loginScreenButtonWidth, height: loginScreenButtonHeight)
                                .background(Color.blue)
                                .cornerRadius(6)
                                .foregroundColor(Color.white)
                        }.padding()
                          
                    }
                    Button(action: createHandle) {
                        Text("Create an Account")
                            .frame(width: loginScreenButtonWidth, height: loginScreenButtonHeight)
                            .background(Color.blue)
                            .cornerRadius(6)
                            .foregroundColor(Color.white)
                    }.padding()
                    
                }
            }.navigationTitle(title)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

