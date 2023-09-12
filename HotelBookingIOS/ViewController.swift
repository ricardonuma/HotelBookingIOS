//
//  ViewController.swift
//  HotelBookingIOS
//
//  Created by Ricardo T. F. Numa on 11/09/23.
//

import UIKit

class ViewController: UITableViewController {
    let urlString = "https://ricardonumahotelbookingapi.azurewebsites.net/api/HotelBooking/getall"
    let screenTitle = "Hotel Bookings"
    let newScreenIdentifier = "New"
    let detailScreenIdentifier = "Detail"
    let cellIdentifier = "HotelBooking"
    var hotelBookings = [HotelBooking]()
    
    @IBAction func NewBookingButtonClick(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: newScreenIdentifier) as? NewViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllBookings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = screenTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getAllBookings()
    }
    
    func getAllBookings() {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }

    // API
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonHotelBookings = try? decoder.decode(HotelBookings.self, from: json) {
            hotelBookings = jsonHotelBookings.value
            hotelBookings.reverse()
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelBookings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = hotelBookings[indexPath.row].clientName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: detailScreenIdentifier) as? DetailViewController {
            vc.selectedBooking = hotelBookings[indexPath.row]
            vc.selectedBookingIndex = indexPath.row + 1
            vc.totalBookings = hotelBookings.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

