import Foundation
@MainActor
class UserViewModel: ObservableObject{
    @Published var users: [UserModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    //service protocol
    private let userService: UserServiceProtocol
    
    //init function
    init(service: UserServiceProtocol) {
        self.userService = service
    }
    
    //load users
    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            let data = try await userService.fetchUsers()
            self.users = data
            print(data)
        } catch {
            errorMessage = error.localizedDescription  
        }
        isLoading = false
    }

    
}
