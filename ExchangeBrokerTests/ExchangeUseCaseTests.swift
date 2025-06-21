//
//  ExchangeUseCaseTests.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

import XCTest
@testable import ExchangeBroker

final class ExchangeUseCaseTests: XCTestCase {
    var sut: ExchangeUseCase!
    var repositoryStub: ExchangeRepositoryStub!
    
    override func setUp() {
        super.setUp()
        repositoryStub = ExchangeRepositoryStub()
        sut = ExchangeUseCase(repository: repositoryStub)
    }
    
    override func tearDown() {
        sut = nil
        repositoryStub = nil
        super.tearDown()
    }
    
    func testGetExchangesWithIconsSuccess() {
        let expectation = XCTestExpectation(description: "GetExchangesWithIcons success")
        let expectedExchange = Exchange.fixture(exchangeId: "123")
        
        let expectedExchangesWithIcon: [ExchangeWithIcon] = [.init(exchange: expectedExchange, iconUrl: "mockedLink")]
        
        repositoryStub.fetchGetExchangesIcons = .success([.init(exchangeId: "123", url: "mockedLink")])
        repositoryStub.fetchGetExchanges = .success([expectedExchange])
        
        sut.getExchangesWithIcons { result in
            switch result {
            case .success(let exchangesWithIcon):
                XCTAssertEqual(exchangesWithIcon, expectedExchangesWithIcon)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetExchangesWithIconsFailure() {
        let expectation = XCTestExpectation(description: "GetExchangesWithIcons failure")
        
        repositoryStub.fetchGetExchangesIcons = .failure(.invalidData)
        repositoryStub.fetchGetExchanges = .failure(.invalidData)
        
        sut.getExchangesWithIcons { result in
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
