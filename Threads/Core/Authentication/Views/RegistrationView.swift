//
//  RegistrationView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer()
                
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    
                    TextField("Enter your full name", text: $viewModel.fullName)
                        .modifier(TextFieldModifier())
                    
                    TextField("Enter your username", text: $viewModel.username)
                        .modifier(TextFieldModifier())
                    
                    TextField("Enter your email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                    
                }//VStack
                
                Button(action: {
                    Task { try await viewModel.createUser() }
                }, label: {
                    Text("Register")
                        .modifier(AuthenticationButtonModifier())
                })//Button
                .opacity(viewModel.fieldsAreEmpty ? 0.7 : 1)
                .disabled(viewModel.fieldsAreEmpty)
                
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
                    .foregroundStyle(.appPrimary)
                    .font(.footnote)
                    .padding(.vertical, 16)
                }//NavigationLink
            }//VStack
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            if viewModel.showLoadingSpinner {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ProgressView()
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
        }//ZStack
    }
}

#Preview {
    RegistrationView()
}
