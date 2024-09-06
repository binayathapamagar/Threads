//
//  LoginView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: Properties
    
    @State private var email = ""
    @State private var password = ""
    
    // MARK: Body
    
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
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your password", text: $password)
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        .padding(.horizontal, 24)
                }//VStack
                
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.vertical)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }//NavigationLink

                Button(action: {}, label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .background(.black)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .padding(.horizontal)
                })//Button
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    Text("Registration View")
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
