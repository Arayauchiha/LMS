import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var userType: UserType = .member
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Login Information")) {
                    Picker("User Type", selection: $userType) {
                        Text("Admin").tag(UserType.admin)
                        Text("Librarian").tag(UserType.librarian)
                        Text("Member").tag(UserType.member)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                }
                
                if let errorMessage = authViewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                Section {
                    Button(action: login) {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text("Login")
                        }
                    }
                    .disabled(email.isEmpty || password.isEmpty || isLoading)
                }
                
                Section {
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                    }
                    
                    if userType == .member {
                        NavigationLink(destination: MemberSignUpView()) {
                            Text("Create Account")
                        }
                    }
                }
            }
            .navigationTitle("Library Management")
        }
    }
    
    private func login() {
        isLoading = true
        
        Task {
            switch userType {
            case .admin:
                await authViewModel.loginAsAdmin(email: email, password: password)
            case .librarian:
                await authViewModel.loginAsLibrarian(email: email, password: password)
            case .member:
                await authViewModel.loginAsMember(email: email, password: password)
            }
            
            isLoading = false
        }
    }
}