//
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 29.11.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    //title atamaları için titleArray oluşturuldu
    private var titles: [Title] = [Title]()

    //UpcomingView için tableview tanımlandı
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        // tabBar ayarlaması yapıldı
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
        
    }
    
    //tableView Layout ve frame tanımlamaları
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
}


//weak self ??
private func fetchUpcoming() {
    APICaller.shared.getUpComingMovies { [weak self] result in
        switch result{
        case .success(let titles):
            self?.titles = titles
            DispatchQueue.main.async {
                self?.upcomingTable.reloadData()
            }
        
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
}


//tableview gereksinimleri
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown"
        return cell
    }
}
