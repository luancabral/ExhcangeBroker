//
//  ServiceTest.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

import XCTest
@testable import ExchangeBroker

struct MockResponse: Codable {
    let message: String
}

final class ServiceTest: XCTestCase {
    var sut: Service!
    var urlSessionStub: URLSessionStub!
    
    override func setUp() {
        super.setUp()
        urlSessionStub = URLSessionStub()
        sut = Service(session: urlSessionStub)
    }
    
    override func tearDown() {
        urlSessionStub = nil
        sut = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        let expectation = XCTestExpectation(description: "Excute success")
        let mockData = MockResponse(message: "response")
        
        urlSessionStub.response = HTTPURLResponse(
            url: URL(string: "mockUrl")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let jsonData = try! JSONEncoder().encode(mockData)
        urlSessionStub.data = jsonData
        
        sut.execute(endpoint: MockEndpoint.mock) { (result : Result<MockResponse, NetworkError>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.message, "response")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testExecuteFailure() {
        let expectation = XCTestExpectation(description: "Excute Failure")
        urlSessionStub.error = NetworkError.invalidURL
        
        sut.execute(endpoint: MockEndpoint.mock) { (result : Result<MockResponse, NetworkError>) in
            switch result {
            case .success(let success):
                XCTFail("Expected failure")
            case .failure(let failure):
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
