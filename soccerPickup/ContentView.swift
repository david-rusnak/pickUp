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
            CreateAccount(page: $page)
        } else if (page == "createProfile") {
            CreateProfile()
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
    @State public var email = ""
    @State public var password = ""
    @Binding var page : String
    
    public var loginScreenButtonWidth = 200.0
    public var loginScreenButtonHeight = 50.0
    
    func createAccountHandle() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    
                    print("success account created")
                }
            }
        // switch page to create profile view
        self.page = "createProfile"
    }
    
    var body: some View {
        VStack {
            // implement firebase create account??? again do we want sso
            Text("Create an Account!")
            
            // Email
            TextField("Email", text: $email).autocapitalization(.none).autocorrectionDisabled(true).padding()
            
            // Password
            SecureField("Password", text: $password).padding()
            
            Button(action: createAccountHandle) {
                Text("Create an Account")
                    .frame(width: loginScreenButtonWidth, height: loginScreenButtonHeight)
                    .background(Color.blue)
                    .cornerRadius(6)
                    .foregroundColor(Color.white)
            }.padding()
            
        }
    }
}

struct CreateProfile: View {
    public var loginScreenButtonWidth = 200.0
    public var loginScreenButtonHeight = 50.0
    
    @State public var username = ""
    @State public var dob = Date()
    @State public var schoolYear = ""
    @State public var sportInterestsSkill = []
    @State var selectedItems = Array<String>()
    
    func createProfile() {
        // add profile properties to firestore
    }
    
    func addSoccer() {
        if (selectedItems.contains("Soccer")) {
            if let index = selectedItems.firstIndex(of: "Soccer") {
                selectedItems.remove(at: index)
            }
        } else {
            selectedItems.append("Soccer")
        }
    }
    
    func addTennis() {
        if (selectedItems.contains("Tennis")) {
            if let index = selectedItems.firstIndex(of: "Tennis") {
                selectedItems.remove(at: index)
            }
        } else {
            selectedItems.append("Tennis")
        }
    }
    
    func addBasketball() {
        if (self.selectedItems.contains("Basketball")) {
            if let index = selectedItems.firstIndex(of: "Basketball") {
                selectedItems.remove(at: index)
            }
        } else {
            selectedItems.append("Basketball")
        }
    }
    
    var body: some View {
        VStack{
            // Username
            TextField("Username", text: $username).autocapitalization(.none).autocorrectionDisabled(true).padding()
            
            // DOB
            DatePicker(
                    "Birth Date",
                    selection: $dob,
                    displayedComponents: [.date]
            ).padding()
            
            // schoolYear
            Form {
                Picker("School Year", selection: $schoolYear) {
                    Text("Freshman").tag("Freshman")
                    Text("Sophomore").tag("Sophomore")
                    Text("Junior").tag("Junior")
                    Text("Senior").tag("Senior")
                }
                
                List {
                    Text("Select sports you would like to play")
                    Button(action: addSoccer) {
                        HStack {
                            Text("Soccer")
                            Image(systemName: "checkmark").opacity(selectedItems.contains("Soccer") ? 1.0 : 0.0)
                        }
                    }
                    Button(action: addTennis) {
                        HStack {
                            Text("Tennis")
                            Image(systemName: "checkmark").opacity(selectedItems.contains("Tennis") ? 1.0 : 0.0)
                        }
                    }
                    Button(action: addBasketball) {
                        HStack {
                            Text("Basketball")
                            Image(systemName: "checkmark").opacity(selectedItems.contains("Basketball") ? 1.0 : 0.0)
                        }
                    }
                }
                
                
            }
            
            // Submit
            Button(action: createProfile) {
                Text("Finish Profile")
                    .frame(width: loginScreenButtonWidth, height: loginScreenButtonHeight)
                    .background(Color.blue)
                    .cornerRadius(6)
                    .foregroundColor(Color.white)
            }.padding()
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

