//
//  APICurrencyRepository.swift
//  GetCurrency
//
//  Created by Kouki Saito on 8/21/19.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import Foundation
import RxSwift

class CachedAPICurrencyRepository: CurrencyRepository {
    func getCurrencyList() -> Observable<[String]> {
        return fetchOrGetLive()
            .map {
                Array($0.quotes.keys).map {
                    String($0.suffix(3))
                }
            }
    }

    func getExchangedCurrencies(sourceCurrency: String, sourceAmount amount: Double) -> Observable<[ExchangedCurrency]> {
        return fetchOrGetLive()
            .map { liveResponse -> (String, Double, [String: Double]) in
                // Search source price
                let sourceQuote = liveResponse.quotes.first { key, price in
                    String(key.suffix(3)) == sourceCurrency
                }

                if let sourceQuote = sourceQuote {
                    return (String(sourceQuote.key.suffix(3)), sourceQuote.value, liveResponse.quotes)
                } else {
                    // If not found the source, it is impossible to calculate prices
                    throw NSError(domain: "not found source currency", code: 404, userInfo: nil)
                }
            }
            .map { sourceCurrency, sourceRate, quotes in
                quotes.map { key, destinationRate in
                    let destinationCurrency = String(key.suffix(3))
                    return ExchangedCurrency(
                        source: sourceCurrency,
                        destination: destinationCurrency,
                        sourceAmount: amount,
                        destinationUnitPrice: destinationRate / sourceRate
                    )
                }.sorted()
            }
    }

    private func fetchOrGetLive() -> Observable<LiveAPIResponse> {
        let userDefault = UserDefaults.standard
        let userDefaultKeyLiveData = "cachedLiveData"
        let userDefaultKeyLastFetchedTime = "fetchedTime"

        // Get from cache
        if let data = userDefault.data(forKey: userDefaultKeyLiveData),
            let lastFetchedDate = userDefault.object(forKey: userDefaultKeyLastFetchedTime) as? Date,
            lastFetchedDate >= Date(timeIntervalSinceNow: -30*60) {
            // Has cached data from 30 minutes
            if let liveResponse = liveAPIResponseFromData(data: data) {
                return Observable.just(liveResponse)
            }
        }

        return Observable.create{ observer in
            let apiUrl = URL(string: "http://www.apilayer.net/api/live?access_key=e339cef22afe296cd6f7e868d5e6a8ce&format=1")!
            URLSession(configuration: .default)
                .dataTask(with: apiUrl) { [weak self] data, response, error in
                    if let data = data, let liveResponse = self?.liveAPIResponseFromData(data: data) {
                        userDefault.set(data, forKey: userDefaultKeyLiveData)
                        userDefault.set(Date(), forKey: userDefaultKeyLastFetchedTime)
                        observer.onNext(liveResponse)
                    } else if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onError(NSError(domain: "Unknown error", code: 0, userInfo: nil))
                    }
                }.resume()
            return Disposables.create()
        }
    }

    private func liveAPIResponseFromData(data: Data) -> LiveAPIResponse? {
        let liveResponse = try? JSONDecoder().decode(LiveAPIResponse.self, from: data)
        return liveResponse
    }

    struct LiveAPIResponse : Codable {
        let success: Bool
        let timestamp: Int
        let source: String
        let quotes: [String: Double]
    }
}
