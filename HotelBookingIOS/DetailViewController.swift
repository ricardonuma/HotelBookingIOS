//
//  DetailViewController.swift
//  HotelBookingIOS
//
//  Created by Ricardo T. F. Numa on 12/09/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var BookingLabel: UILabel!
    
    var selectedBooking: HotelBooking?
    var selectedBookingIndex = 0
    var totalBookings = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Booking \(selectedBookingIndex) of \(totalBookings)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let booking = selectedBooking {
            var text = "Id: \(booking.id)\n"
            text.append("Room Number: \(booking.roomNumber)\n")
            text.append("Client Name: \(booking.clientName)")
            BookingLabel.text = text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
