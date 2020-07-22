//
//  LoginView.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 18.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI


struct LoginView: View {
    @State var username = "Boozeman"
    @State var password = "v3rySafePassw0rd"
    @State var loginState: Bool = false

    var loginController = LoginController.instance

    var body: some View {
        VStack() {
            Text("Dr. Booze")
                    .font(.largeTitle).foregroundColor(Color.primary)
                    .padding([.top, .bottom], 40)
                    .shadow(radius: 10.0, x: 20, y: 10)

            Image("Logo")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding(.bottom, 50)

            VStack(alignment: .leading, spacing: 15) {
                ZStack(alignment: .leading) {
                    TextField("", text: $username)
                            .padding()
                            .background(Color.dark)
                            .foregroundColor(Color.light)
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)

                    if username.isEmpty {
                        Text("Username").foregroundColor(.medium).padding(.leading)
                    }
                }

                ZStack(alignment: .leading) {
                    SecureField("Password", text: self.$password)
                            .padding()
                            .background(Color.dark)
                            .foregroundColor(Color.light)
                            .cornerRadius(20)
                            .shadow(radius: 10.0, x: 20, y: 10)

                    if password.isEmpty {
                        Text("Password").foregroundColor(.medium)
                                .padding(.leading)
                    }
                }
            }.padding([.leading, .trailing], 27.5)

            Button(action: {
                self.loginController.login(self.username, withPassword: self.password, binding: self.$loginState)
            }) {
                Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.primary)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
            }
                    .padding(.top, 50)
            NavigationLink(destination: Master(), isActive: self.$loginState){ EmptyView()}
            Spacer()

            HStack(spacing: 0) {
                Text("Don't have an account? ")
                NavigationLink(destination: RegisterView()) {
                    Text("Sign Up")
                }
            }.padding(.bottom, 10.0)
        }
                .navigationBarBackButtonHidden(true)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
