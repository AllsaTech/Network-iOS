import XCTest
import Combine
@testable import Network

final class NetworkTests: XCTestCase {


    static var allTests = [
        ("test_getAnonymousToken", test_getAnonymousToken),
        ("test_loginRequest", test_loginRequest)
    ]
    
    var cancellable = Set<AnyCancellable>()

    func test_getAnonymousToken() {
        let expectation = XCTestExpectation(description: "Download apple.com home page")
        let repository = AuthenticationService()

        repository.getAnonymousToken()
            .sink(receiveCompletion: { (completion) in

            }) { (response) in
                print(response)
                expectation.fulfill()
        }
        .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)

    }
    
    func test_loginRequest() {
        let expectation = XCTestExpectation(description: "Download apple.com home page")
        let repository = AuthenticationService()
        
        let loginRequest = AuthenticationService.Login.Request(
            username: "ozgur@ozgur.com",
            password: "123123!*Er"
        )
        
        repository
            .login(withRequestParams: loginRequest)
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }, receiveValue: { value in
                print(value)
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
    }
    
    
}
