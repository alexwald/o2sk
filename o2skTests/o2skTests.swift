import XCTest
@testable import wald

final class o2skTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_validator() throws {
        let validator = ActivationValidator()
        
        XCTAssertTrue(validator.isActivationValidFrom(response: ActivationResponseModel(ios: "6.199999")))
        XCTAssertTrue(validator.isActivationValidFrom(response: ActivationResponseModel(ios: "6.2")))
        XCTAssertFalse(validator.isActivationValidFrom(response: ActivationResponseModel(ios: "6.1")))
        XCTAssertFalse(validator.isActivationValidFrom(response: ActivationResponseModel(ios: "wrong input")))
    }
    
    func test_client() async throws {
       let deps =  CardDependencies(host: Config.serverURL)

        Task {
            do {
                let model = try await deps.activationClient.activate(code: UUID().uuidString)
                
            } catch {
               assertionFailure("activation client failed")
            }
        }
    }
    
    //TODO: additionally test view logic, but there's no time at this moment
}
