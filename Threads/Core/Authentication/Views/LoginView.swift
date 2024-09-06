//
//  LoginView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
        
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()

                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(TextFieldModifier())
                }//VStack
                
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }//NavigationLink

                Button(action: {}, label: {
                    Text("Login")
                        .modifier(AuthenticationButtonModifier())
                })//Button
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }//HStack
                    .foregroundStyle(.black)
                    .font(.footnote)
                    .padding(.vertical, 16)
                }//NavigationLink

                
            }//VStack
            
        }//NavigationStack
    }
}

#Preview {
    LoginView()
}
