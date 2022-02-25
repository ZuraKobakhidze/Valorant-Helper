//
//  Endpoints.swift
//  GoodNetworkLayer
//
//  Created by Zura Kobakhidze on 02.02.22.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
}
