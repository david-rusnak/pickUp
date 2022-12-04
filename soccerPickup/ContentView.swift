//
//  ContentView.swift
//  soccerPickup
//
//  Created by David Rusnak on 12/3/22.
//

import SwiftUI
import CoreData
import Firebase



struct ContentView: View {
    // integrate firebase auth???? do we want sso
    @State var page = "welcome"
    var body: some View {
        if (page == "home") {
            AppHome()
        } else if (page == "welcome") {
            Welcome(page: $page)
        } else if (page == "createAccount") {
            CreateAccount()
        }
    }
}

struct AppHome: View {
    var body: some View {
        VStack {
            // design this screen
            Text("Home screen")
        }
        
    }
}

struct CreateAccount: View {
    var body: some View {
        VStack {
            // implement firebase create account??? again do we want sso
            Text("Create an Account!")
        }
    }
}

struct Welcome: View {
    @State public var email = ""
    @State public var password = ""
    @State public var activeScreen = "welcome"
    @Binding var page : String
    
    // Put this into a separate style file????
    public var buttonRadius = 6
    public var loginScreenButtonWidth = 200.0
    public var loginScreenButtonHeight = 50.0
    public var title = "Welcome to Pick^"
    public var createAccount = "Create an Account"
    
    func login() {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    self.page = "home";
                    print("success")
                }
            }
    }
    
    func loginHandle() {
        print("login handle")
        //self.page = "home";
    }
    
    func createHandle() {
        print("create account handle")
        self.page = "createAccount";
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    // Email
                    TextField("Email", text: $email).autocapitalization(.none).autocorrectionDisabled(true).padding()
                    
                    // Password
                    SecureField("Password", text: $password).padding()
                    
                    // If there is something in both fields, show login button
                    if (email.count > 0 && password.count > 0) {
                          
                        Button(action: login) {
                            Text("Login")
                                .frame(width: loginScreenButtonWidth, height: loginScreenButtonHeight)
                                .background(Color.blue)
                                .cornerRadius(6)
                                .foregroundColor(Color.white)
                        }.padding()
                          
                    }
                    
                    // Always show the create account button
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

