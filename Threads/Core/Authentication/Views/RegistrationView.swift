//
//  RegistrationView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                
                TextField("Enter your full name", text: $fullName)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your username", text: $username)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .modifier(TextFieldModifier())
                
                SecureField("Enter your password", text: $password)
                    .modifier(TextFieldModifier())
                
            }//VStack
            
            Button(action: {}, label: {
                Text("Register")
                    .modifier(AuthenticationButtonModifier())
            })//Button
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.bold)
                }//HStack
                .foregroundStyle(.black)
                .font(.footnote)
                .padding(.vertical, 16)
            }//NavigationLink
            
            
        }//VStack
    }
}

#Preview {
    RegistrationView()
}
