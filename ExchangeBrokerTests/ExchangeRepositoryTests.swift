//
//  ExchangeRepositoryTests.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

import XCTest
@testable import ExchangeBroker

final class ExchangeRepositoryTests: XCTestCase {
    var sut: ExchangeRepository!
    var serviceStub: ServiceStub!
    
    override func setUp() {
        super.setUp()
        serviceStub = ServiceStub()
        sut = ExchangeRepository(service: serviceStub)
    }
    
    override func tearDown() {
        serviceStub = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetExchangesSuccess() {
        let expectation = expectation(description: "GetExchanges success")
        let expectedExchanges: [Exchange] = [.fixture()]
        serviceStub.mockResponse = expectedExchanges
        
        sut.getExchanges { result in
            switch result {
            case .success(let exchanges):
                XCTAssertEqual(exchanges, expectedExchanges)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetExchangesFailure() {
        serviceStub.shouldFail = true
        let expectation = XCTestExpectation(description: "GetExchanges failure")
        
        sut.getExchanges { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetExchangesIconsSuccess() {
        let expectation = expectation(description: "GetExchangesIcons success")
        let expectedExchangesIcons: [ExchangeIcon] = [.init(exchangeId: "123", url: "mockUrl")]
        serviceStub.mockResponse = expectedExchangesIcons
        
        sut.getExchangesIcons { result in
            switch result {
            case .success(let exchangesIcons):
                XCTAssertEqual(exchangesIcons, expectedExchangesIcons)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetExchangesIconsFailure() {
        serviceStub.shouldFail = true
        let expectation = XCTestExpectation(description: "GetExchangesIcons failure")
        
        sut.getExchangesIcons { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
