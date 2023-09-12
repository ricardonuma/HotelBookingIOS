//
//  HotelClient.swift
//  Project1
//
//  Created by Ricardo T. F. Numa on 1/09/23.
//

import Foundation

struct HotelBooking: Codable {
    var id: Int
    var roomNumber: Int
    var clientName: String?
}
