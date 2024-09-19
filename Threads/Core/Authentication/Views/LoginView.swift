//
//  LoginView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    Spacer()
                    
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding()
                    
                    VStack {
                        TextField("Enter your email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .modifier(TextFieldModifier())
                        
                        SecureField("Enter your password", text: $viewModel.password)
                            .modifier(TextFieldModifier())
                    }//VStack
                    
                    NavigationLink {
                        Text("Forgot Password")
                    } label: {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.appPrimary)
                            .padding(.top)
                            .padding(.trailing, 28)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }//NavigationLink
                    
                    Button(action: {
                        Task { try await viewModel.login() }
                    }, label: {
                        Text("Login")
                            .modifier(AuthenticationButtonModifier())
                    })//Button
                    .opacity(viewModel.fieldsAreEmpty ? 0.7 : 1)
                    .disabled(viewModel.fieldsAreEmpty)
                    
                    Spacer()
                    
                    Divider()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            
                            Text("Sign Up")
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
                        AuthProgressView()
                    }
                }
            }//ZStack
        }//NavigationStack
    }
}

#Preview {
    LoginView()
}
