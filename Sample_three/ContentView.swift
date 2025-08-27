
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel(service: UserService())
    var body: some View {
        NavigationStack{
            // view is loading
            if viewModel.isLoading {
                ProgressView("user loading...")
            }
            
            //error in loading
            else if let error = viewModel.errorMessage {
                VStack{
                    Text("Error: \(error)")
                    Button("Retry") {
                        Task{await viewModel.loadUsers()}
                    }
                }
            }
            
            //no users found
            
            else if viewModel.users.isEmpty {
                Text("No users found")
            }
            
            //view is loaded
            
            else {
                List(viewModel.users) { user in
                    Text("\(user.name)")
                }
                .navigationTitle("Users")
                
            }
            
            
        }
        .onAppear {
            Task{await viewModel.loadUsers()}
        }
    }
}

#Preview {
    ContentView()
}
