import Foundation
protocol UserServiceProtocol {
    func fetchUsers() async throws -> [UserModel]
}

class UserService: UserServiceProtocol {
    func fetchUsers() async throws -> [UserModel] {
        //url object
        guard let url = URL(string: "https://fake-json-api.mock.beeceptor.com/users")else {
            throw URLError(.badURL)
        }
        //get back json
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //check response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
             
       //decode json
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let users = try decoder.decode([UserModel].self, from: data)
        return users
        
    }
   
}
