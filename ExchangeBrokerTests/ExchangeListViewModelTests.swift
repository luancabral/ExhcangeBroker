//
//  ExchangeListViewModel.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

import XCTest
@testable import ExchangeBroker

final class ExchangeListViewModelTests: XCTestCase {
    private var sut: ExchangeListViewModel!
    private var useCaseStub: ExchangeUseCaseStub!
    private var onDidDelegateHit: ((DelegateHit) -> Void)?
    private var onDidCoordinatorHit: ((CoordinatorHit) -> Void)?
    
    enum DelegateHit {
        case reloadData
        case error
    }
    
    enum CoordinatorHit {
        case hitExchangeDetails
    }
    
    override func setUp() {
        super.setUp()
        useCaseStub = ExchangeUseCaseStub()
        sut = ExchangeListViewModel(exchangeUseCases: useCaseStub, coordinator: self)
        sut.delegate = self
    }
    
    override func tearDown() {
        sut = nil
        useCaseStub = nil
        onDidDelegateHit = nil
        onDidCoordinatorHit = nil
        super.tearDown()
    }
    
    func testFetchExchangesSuccess() {
        let expectation = expectation(description: "FetchExchanges Success")
        let expectedExchange: [ExchangeWithIcon] = [.init(exchange: Exchange.fixture(exchangeId: "123"),
                                                          iconUrl: "iconUrl")]
        useCaseStub.fetchExchangeWithIcon = .success(expectedExchange)
        
        onDidDelegateHit = { hit in
            if case .reloadData = hit {
                XCTAssertEqual(self.sut.exchanges, expectedExchange)
                expectation.fulfill()
            }
        }
        
        sut.fetchExchanges()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchExchangesFailure() {
        let expectation = expectation(description: "FetchExchanges Failure")
        useCaseStub.fetchExchangeWithIcon = .failure(.invalidData)
        
        onDidDelegateHit = { hit in
            if case .error = hit {
                expectation.fulfill()
            }
        }
        
        sut.fetchExchanges()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDidSelectExchange() {
        let expectation = expectation(description: "DidSelectExchange Hits")
        
        onDidCoordinatorHit = { hit in
            if case .hitExchangeDetails = hit {
                expectation.fulfill()
            }
        }
        
        sut.didSelectExchange(with: .init(exchange: Exchange.fixture(), iconUrl: "iconUrl"))
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testBuildExchangeCellViewModel() {
        let expectation = expectation(description: "FetchExchanges Success")
        let expectedExchange: [ExchangeWithIcon] = [.init(exchange: Exchange.fixture(exchangeId: "123", name: "exchangeName"),
                                                          iconUrl: "iconUrl")]
        useCaseStub.fetchExchangeWithIcon = .success(expectedExchange)
        
        onDidDelegateHit = { hit in
            if case .reloadData = hit {
                XCTAssertEqual(self.sut.buildExchangeCellViewModel(for: 0).name, "exchangeName")
                expectation.fulfill()
            }
        }
        
        sut.fetchExchanges()
        wait(for: [expectation], timeout: 1.0)
    }
}

extension ExchangeListViewModelTests: ExchangeListViewModelViewDelegate {
    func reloadData(with exchanges: [ExchangeBroker.ExchangeWithIcon]) {
        onDidDelegateHit?(.reloadData)
    }
    
    func set(loading: Bool) {
        return
    }
    
    func set(error: NetworkError, tryAgainAction: (() -> Void)?) {
        onDidDelegateHit?(.error)
    }
}

extension ExchangeListViewModelTests: ExchangeListCoordinatorProtocol {
    func goToExchangeDetails(with exchange: ExchangeBroker.ExchangeWithIcon) {
        onDidCoordinatorHit?(.hitExchangeDetails)
    }
}
